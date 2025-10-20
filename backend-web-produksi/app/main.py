from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
from .db import prisma
from .routers.market.input_desain import router as dropdown_router
from pathlib import Path
from dotenv import load_dotenv

# Optional money routers: guard imports so the API can boot even if these modules are incomplete
try:  # noqa: SIM105
	from .routers.money.pendapatan import router as pendapatan_router  # type: ignore
except Exception:
	pendapatan_router = None  # type: ignore

try:  # noqa: SIM105
	from .routers.money.gaji import router as gaji_router  # type: ignore
except Exception:
	gaji_router = None  # type: ignore

app = FastAPI(title="ERP Sakura API", version="0.1.0")

# Load Prisma .env (DATABASE_URL) if present
try:
    prisma_env = Path(__file__).resolve().parents[1] / "prisma" / ".env"
    if prisma_env.exists():
        load_dotenv(dotenv_path=prisma_env, override=False)
except Exception:
    pass

app.add_middleware(
	CORSMiddleware,
	allow_origins=["*"],
	allow_credentials=True,
	allow_methods=["*"],
	allow_headers=["*"],
)

@app.on_event("startup")
async def on_startup():
    # Skip DB connection on startup to allow stateless endpoints (like dropdowns) to work offline
    return None

@app.on_event("shutdown")
async def on_shutdown():
    return None

@app.get("/health")
async def health():
	return {"status": "ok"}

if pendapatan_router is not None:
	app.include_router(pendapatan_router)
if gaji_router is not None:
	app.include_router(gaji_router)
app.include_router(dropdown_router)

# Serve built frontend (Vite dist) as static files with SPA fallback
try:
	dist_dir = Path(__file__).resolve().parents[2] / "dist"
	if dist_dir.exists():
		app.mount("/", StaticFiles(directory=str(dist_dir), html=True), name="static")

		@app.get("/{full_path:path}")
		async def spa_fallback(full_path: str):  # noqa: ARG001
			index_file = dist_dir / "index.html"
			if index_file.exists():
				return FileResponse(str(index_file))
			return {"message": "build not found"}
except Exception:
	# If dist not found, API still works (useful for local dev)
	pass

