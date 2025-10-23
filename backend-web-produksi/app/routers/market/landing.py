from fastapi import APIRouter, UploadFile, File, HTTPException
from typing import List
from uuid import uuid4
from pathlib import Path

router = APIRouter(prefix="/api/landing", tags=["landing"])

# Resolve upload dir relative to this file
BASE_DIR = Path(__file__).resolve().parents[3]  # .../backend-web-produksi
UPLOAD_DIR = BASE_DIR / "uploads"
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

@router.post("/upload/")
async def upload_images(files: List[UploadFile] = File(...)):
    if not files:
        raise HTTPException(status_code=400, detail="No files provided")
    urls: List[str] = []
    for f in files:
        suffix = Path(f.filename or "").suffix.lower() or ".jpg"
        name = f"{uuid4().hex}{suffix}"
        dest = UPLOAD_DIR / name
        content = await f.read()
        dest.write_bytes(content)
        urls.append(f"/uploads/{name}")
    return {"urls": urls}

