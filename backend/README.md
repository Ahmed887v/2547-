# SpeakLocal Smart Tutor backend

This is the real server-side AI tutor. It uses the OpenAI API, which is separate
from a ChatGPT subscription and is billed according to API usage.

## Deploy on Render

1. Push this repository to GitHub.
2. In Render, choose New -> Blueprint and select this repository.
3. Render reads the root render.yaml and builds the Docker service.
4. In the service environment, set OPENAI_API_KEY to a newly created API key.
   Keep the key in Render's secret environment variables only. Never commit it.
5. Wait for deployment. Render assigns the public HTTPS URL; use that exact URL.
6. Open https://YOUR-RENDER-HOST/health and confirm status=ok,
   provider_configured=true, and non-zero content bank counts.
7. The Flutter endpoint is that base URL plus /api/tutor/chat.

## Local run

From the repository root:
    cd backend
    python3 -m venv .venv
    . .venv/bin/activate
    pip install -r requirements.txt
    export OPENAI_API_KEY='set-this-in-your-shell-only'
    export VOCABULARY_BANK='../assets/content/1000_english_words.md'
    export EXPRESSIONS_BANK='../assets/content/1000_american_slang_expressions.md'
    uvicorn main:app --host 0.0.0.0 --port 8000

Health: http://127.0.0.1:8000/health

POST /api/tutor/chat accepts the JSON shape already sent by Android:
message, history, language, and mode. It returns {"reply":"..."}.

The service loads both original Markdown banks at startup, deduplicates repeated
contextual variants by normalized headword/expression, and supplies relevant
entries to the tutor prompt. /health reports the unique counts.

## Security

- Provider key remains server-side; it is never compiled into the APK.
- Message size and history length are bounded, with an IP-based rate limit.
- Raw provider exceptions and credentials are never returned to clients.
- For high traffic, use shared rate limiting (Redis), monitoring, and a managed
  WAF. The included in-memory limiter is per process, not a distributed defense.
