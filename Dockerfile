# Multi-stage: build frontend, then run FastAPI serving API + static

# 1) Frontend build
FROM node:20-alpine AS webbuild
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 2) Backend runtime
FROM python:3.11-slim AS runtime
ENV PYTHONUNBUFFERED=1
ENV PORT=8080
WORKDIR /app

# System deps (optional): libpq for Postgres client if needed later
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy backend
COPY backend-web-produksi /app/backend-web-produksi
# Copy frontend build output from stage 1
COPY --from=webbuild /app/dist /app/dist

# Python deps
RUN pip install --no-cache-dir -r /app/backend-web-produksi/requirements.txt

# Generate Prisma Python client (uses schema at backend-web-produksi/prisma/schema.prisma)
RUN python -m prisma generate --schema /app/backend-web-produksi/prisma/schema.prisma || true

# Expose port
EXPOSE 8080

# Start uvicorn; app serves SPA from /app/dist via main.py
# Use PORT env if provided by platform (Koyeb, Render, etc.), default 8080
CMD ["sh", "-c", "uvicorn backend-web-produksi.app.main:app --host 0.0.0.0 --port ${PORT:-8080}"]
