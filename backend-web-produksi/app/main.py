from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
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

# Static uploads directory
try:
    UPLOAD_DIR = Path(__file__).resolve().parents[1] / "uploads"
    UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
    app.mount("/uploads", StaticFiles(directory=str(UPLOAD_DIR)), name="uploads")
except Exception:
    pass

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

try:
	from .routers.market.landing import router as landing_router  # type: ignore
	app.include_router(landing_router)
except Exception:
	pass

