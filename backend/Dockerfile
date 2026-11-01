FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1
WORKDIR /app
COPY backend/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt && mkdir -p /app/content
COPY backend/ /app/
COPY assets/content/1000_english_words.md /app/content/1000_english_words.md
COPY assets/content/1000_american_slang_expressions.md /app/content/1000_american_slang_expressions.md
EXPOSE 8000
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
