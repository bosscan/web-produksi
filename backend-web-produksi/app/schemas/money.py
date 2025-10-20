from pydantic import BaseModel
from typing import Optional


class OmsetPendapatanIn(BaseModel):
    tanggal: str
    tipe_transaksi: str
    nominal: int
    id_spk: Optional[str] = None
    id_rekap_custom: Optional[str] = None
    id_custom: Optional[str] = None


class OmsetPendapatanOut(OmsetPendapatanIn):
    id: int


class PengeluaranGajiIn(BaseModel):
    date: str
    employee: str
    division: str
    base: int
    overtime: int
    bonus: int
    deduction: int
    notes: Optional[str] = None


class PengeluaranGajiOut(PengeluaranGajiIn):
    id: int
