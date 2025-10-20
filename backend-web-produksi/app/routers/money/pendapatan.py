from fastapi import APIRouter, HTTPException
from ...db import prisma
from ...schemas.money import OmsetPendapatanIn, OmsetPendapatanOut

router = APIRouter(prefix="/money/pendapatan", tags=["money-pendapatan"])


@router.post("/", response_model=OmsetPendapatanOut)
async def create_pendapatan(payload: OmsetPendapatanIn):
	record = await prisma.omset_pendapatan.create({
		'data': payload.model_dump()
	})
	return record


@router.get("/", response_model=list[OmsetPendapatanOut])
async def list_pendapatan():
	items = await prisma.omset_pendapatan.find_many(order={'id': 'desc'})
	return items


@router.get("/{id}", response_model=OmsetPendapatanOut)
async def get_pendapatan(id: int):
	item = await prisma.omset_pendapatan.find_unique(where={'id': id})
	if not item:
		raise HTTPException(status_code=404, detail="Not found")
	return item


@router.delete("/{id}")
async def delete_pendapatan(id: int):
	await prisma.omset_pendapatan.delete(where={'id': id})
	return {"ok": True}

