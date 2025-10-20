from fastapi import APIRouter
from pathlib import Path
import re

router = APIRouter(prefix="/api/dropdown", tags=["dropdown"])

SCHEMA_PATH = Path(__file__).resolve().parents[3] / "prisma" / "schema.prisma"

def _title_from_enum(val: str) -> str:
	"""Convert ENUM_CASE to Title Case while preserving certain domain words."""
	# Basic title-casing from ENUM_CASE -> "Enum Case"
	s = val.replace("_", " ").title()
	# Domain-specific fix-ups
	s = s.replace("Kpc 2 Warna", "KPC 2 Warna")
	return s

def _parse_prisma_enums() -> dict:
	"""Parse enum blocks from Prisma schema file and return a map of name -> [symbols]."""
	text = SCHEMA_PATH.read_text(encoding="utf-8")
	# Regex to capture enum blocks: enum Name { ... }
	pattern = re.compile(r"enum\s+(\w+)\s*\{([^}]*)\}", re.MULTILINE)
	enums: dict[str, list[str]] = {}
	for m in pattern.finditer(text):
		name = m.group(1)
		body = m.group(2)
		# Extract symbols (ignore comments/blank lines)
		symbols = []
		for line in body.splitlines():
			line = line.strip()
			if not line or line.startswith("//"):
				continue
			# Take first token until any whitespace or inline comment
			token = line.split("//")[0].strip().split()[0]
			if token:
				symbols.append(token)
		if symbols:
			enums[name] = symbols
	return enums

_ENUM_CACHE = None

def _get_enums():
	global _ENUM_CACHE
	if _ENUM_CACHE is None:
		try:
			_ENUM_CACHE = _parse_prisma_enums()
		except Exception:
			_ENUM_CACHE = {}
	return _ENUM_CACHE

KEY_TO_ENUM = {
	# Spesifikasi Desain
	"sample": "Sample",
	"jenis_produk": "JenisProduk",
	"jenis_pola": "JenisPola",
	"jenis_kain": "JenisKain",
	# Detail Produk
	"aplikasi": "Aplikasi",
	"jenis_bordir": "JenisBordir",
	"jenis_sablon": "JenisSablon",
	"hoodie": "Hoodie",
	"potongan_bawah": "PotonganBawah",
	"belahan_samping": "BelahanSamping",
	"kerah": "Kerah",
	"plaket": "Plaket",
	"saku": "Saku",
	"saku_bawah": "SakuBawah",
	"saku_furing": "SakuFuring",
	"ujung_lengan": "UjungLengan",
	"kancing_depan": "KancingDepan",
	# Detail Tambahan
	"tali_bawah": "TaliBawah",
	"tali_lengan": "TaliLengan",
	"ban_bawah": "BanBawah",
	"skoder": "Skoder",
	"varian_saku": "VariasiSaku",
	"warna_list_reflektor": "WarnaListReflektor",
	"ventilasi": "Ventilasi",
	"tempat_pulpen": "TempatPulpen",
	"lidah_kucing": "LidahKucing",
	"tempat_lanyard": "TempatLanyard",
	"gantungan_ht": "GantunganHT",
}

@router.get("/attributes")
async def list_attributes():
	# Provide the keys and mapping to enum names so frontend can request options or use bulk endpoint
	enums = _get_enums()
	result = []
	for key, enum_name in KEY_TO_ENUM.items():
		if enum_name in enums:
			result.append({"id": len(result)+1, "key": key, "enum": enum_name})
	return result

@router.get("/options")
async def list_options():
	enums = _get_enums()
	items = []
	for key, enum_name in KEY_TO_ENUM.items():
		vals = enums.get(enum_name, [])
		for v in vals:
			items.append({
				"attribute": key,
				"value": v,
				"label": _title_from_enum(v),
				"is_active": True,
			})
	return items

@router.get("/enums")
async def list_all_enums():
	enums = _get_enums()
	return {k: v for k, v in enums.items() if k in KEY_TO_ENUM.values()}
