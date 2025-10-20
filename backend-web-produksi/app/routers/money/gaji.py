from fastapi import APIRouter, HTTPException
from ...db import prisma
from ...schemas.money import PengeluaranGajiIn, PengeluaranGajiOut

router = APIRouter(prefix="/money/gaji", tags=["money-gaji"])


@router.post("/", response_model=PengeluaranGajiOut)
async def create_gaji(payload: PengeluaranGajiIn):
    record = await prisma.pengeluaran_gaji.create({'data': payload.model_dump()})
    return record


@router.get("/", response_model=list[PengeluaranGajiOut])
async def list_gaji():
    items = await prisma.pengeluaran_gaji.find_many(order={'id': 'desc'})
    return items


@router.get("/{id}", response_model=PengeluaranGajiOut)
async def get_gaji(id: int):
    item = await prisma.pengeluaran_gaji.find_unique(where={'id': id})
    if not item:
        raise HTTPException(status_code=404, detail="Not found")
    return item


@router.delete("/{id}")
async def delete_gaji(id: int):
    await prisma.pengeluaran_gaji.delete(where={'id': id})
    return {"ok": True}
