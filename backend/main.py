"""SpeakLocal Smart Tutor API. Provider credentials stay server-side."""
from __future__ import annotations
import os, time
from collections import defaultdict, deque
from pathlib import Path
from typing import Literal
from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from openai import AsyncOpenAI
from pydantic import BaseModel, Field
from content_bank import ContentBank

MODEL = os.getenv("OPENAI_MODEL", "gpt-4o-mini")
MAX_MESSAGE_CHARS = int(os.getenv("MAX_MESSAGE_CHARS", "4000"))
MAX_HISTORY_TURNS = int(os.getenv("MAX_HISTORY_TURNS", "20"))
RATE_LIMIT_REQUESTS = int(os.getenv("RATE_LIMIT_REQUESTS", "20"))
RATE_LIMIT_WINDOW_SECONDS = int(os.getenv("RATE_LIMIT_WINDOW_SECONDS", "60"))
app = FastAPI(title="SpeakLocal Smart Tutor API", version="1.0.0")
origins = [v.strip() for v in os.getenv("CORS_ORIGINS", "").split(",") if v.strip()]
if origins:
    app.add_middleware(CORSMiddleware, allow_origins=origins, allow_credentials=False,
                       allow_methods=["GET", "POST"], allow_headers=["Content-Type"])
bank = ContentBank(
    Path(os.getenv("VOCABULARY_BANK", "/app/content/1000_english_words.md")),
    Path(os.getenv("EXPRESSIONS_BANK", "/app/content/1000_american_slang_expressions.md")))
client: AsyncOpenAI | None = None
_requests: dict[str, deque[float]] = defaultdict(deque)

class ChatMessage(BaseModel):
    role: Literal["user", "assistant"]
    content: str = Field(min_length=1, max_length=MAX_MESSAGE_CHARS)

class TutorRequest(BaseModel):
    message: str = Field(min_length=1, max_length=MAX_MESSAGE_CHARS)
    history: list[ChatMessage] = Field(default_factory=list, max_length=MAX_HISTORY_TURNS)
    language: Literal["en", "ar"] = "en"
    mode: Literal["english_tutor"] = "english_tutor"

def enforce_rate_limit(request: Request) -> None:
    forwarded = request.headers.get("x-forwarded-for", "")
    ip = forwarded.split(",")[0].strip() if forwarded else (request.client.host if request.client else "unknown")
    now = time.monotonic()
    bucket = _requests[ip]
    while bucket and bucket[0] < now - RATE_LIMIT_WINDOW_SECONDS:
        bucket.popleft()
    if len(bucket) >= RATE_LIMIT_REQUESTS:
        raise HTTPException(status_code=429, detail="Too many requests. Please wait a moment.")
    bucket.append(now)

@app.on_event("startup")
async def startup() -> None:
    global client
    bank.load()
    key = os.getenv("OPENAI_API_KEY", "").strip()
    if key:
        client = AsyncOpenAI(api_key=key)

@app.get("/health")
async def health() -> dict:
    return {"status": "ok", "service": "speaklocal-smart-tutor", "model": MODEL,
            "provider_configured": bool(os.getenv("OPENAI_API_KEY", "").strip()),
            "content_bank": bank.stats}

@app.post("/api/tutor/chat")
async def tutor_chat(payload: TutorRequest, request: Request) -> dict[str, str]:
    enforce_rate_limit(request)
    if client is None:
        raise HTTPException(status_code=503, detail="The tutor AI provider is not configured on the server.")
    message = payload.message.strip()
    if not message:
        raise HTTPException(status_code=422, detail="Message cannot be empty.")
    entries = bank.find_relevant(message, limit=8)
    context = "\n".join(
        f"- {e['prompt']}: {e['meaning']} | Arabic: {e['arabic']} | Example: {e['example']}"
        for e in entries) or "No directly matching bank entries; teach from general English knowledge."
    system = f"""You are SpeakLocal, a patient, highly capable English tutor for an Arabic-speaking learner.
Reply primarily in clear, natural English at the learner's apparent level. Correct mistakes gently,
show a natural corrected sentence, and briefly explain why. Ask one useful follow-up question when
it helps conversation practice. If the learner writes Arabic, understand the request and explain
difficult points in concise Arabic when useful, while keeping practice examples in English.
Adapt difficulty gradually. Be encouraging but honest. Never invent a pronunciation score: the app's
speech score is a transcript similarity estimate, not acoustic phoneme analysis. Use the supplied
SpeakLocal bank when relevant, but never force irrelevant items. Keep replies focused, usually 2-6
short paragraphs or a compact exercise.

Relevant SpeakLocal learning-bank entries:
{context}"""
    messages = [{"role": "system", "content": system}]
    messages.extend({"role": item.role, "content": item.content} for item in payload.history[-MAX_HISTORY_TURNS:])
    messages.append({"role": "user", "content": message})
    try:
        result = await client.chat.completions.create(
            model=MODEL, messages=messages, temperature=0.65, max_tokens=700)
        reply = (result.choices[0].message.content or "").strip()
        if not reply:
            raise HTTPException(status_code=502, detail="The AI provider returned an empty reply.")
        return {"reply": reply}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(status_code=502, detail="The AI tutor is temporarily unavailable. Please try again.")
