import { readFileSync } from 'node:fs';
import { join } from 'node:path';

const SCHEMA_PATH = join(process.cwd(), 'backend-web-produksi', 'prisma', 'schema.prisma');

function titleFromEnum(val: string): string {
  const s = val.replace(/_/g, ' ').toLowerCase().replace(/\b\w/g, (m) => m.toUpperCase());
  return s.replace('Kpc 2 Warna', 'KPC 2 Warna');
}

function parsePrismaEnums(): Record<string, string[]> {
  const text = readFileSync(SCHEMA_PATH, 'utf8');
  const pattern = /enum\s+(\w+)\s*\{([^}]*)\}/gm;
  const enums: Record<string, string[]> = {};
  let m: RegExpExecArray | null;
  while ((m = pattern.exec(text))) {
    const name = m[1];
    const body = m[2];
    const symbols = body
      .split('\n')
      .map((l) => l.trim())
      .filter((l) => l && !l.startsWith('//'))
      .map((l) => l.split('//')[0].trim().split(/\s+/)[0])
      .filter(Boolean);
    if (symbols.length) enums[name] = symbols as string[];
  }
  return enums;
}

const KEY_TO_ENUM: Record<string, string> = {
  sample: 'Sample',
  jenis_produk: 'JenisProduk',
  jenis_pola: 'JenisPola',
  jenis_kain: 'JenisKain',
  aplikasi: 'Aplikasi',
  jenis_bordir: 'JenisBordir',
  jenis_sablon: 'JenisSablon',
  hoodie: 'Hoodie',
  potongan_bawah: 'PotonganBawah',
  belahan_samping: 'BelahanSamping',
  kerah: 'Kerah',
  plaket: 'Plaket',
  saku: 'Saku',
  saku_bawah: 'SakuBawah',
  saku_furing: 'SakuFuring',
  ujung_lengan: 'UjungLengan',
  kancing_depan: 'KancingDepan',
  tali_bawah: 'TaliBawah',
  tali_lengan: 'TaliLengan',
  ban_bawah: 'BanBawah',
  skoder: 'Skoder',
  varian_saku: 'VariasiSaku',
  warna_list_reflektor: 'WarnaListReflektor',
  ventilasi: 'Ventilasi',
  tempat_pulpen: 'TempatPulpen',
  lidah_kucing: 'LidahKucing',
  tempat_lanyard: 'TempatLanyard',
  gantungan_ht: 'GantunganHT',
};

export default function handler(req: any, res: any) {
  try {
    const enums = parsePrismaEnums();
    const items: Array<{ attribute: string; value: string; label: string; is_active: boolean }> = [];
    for (const [key, ename] of Object.entries(KEY_TO_ENUM)) {
      const vals = enums[ename] || [];
      for (const v of vals) {
        items.push({ attribute: key, value: v, label: titleFromEnum(v), is_active: true });
      }
    }
    res.setHeader('Cache-Control', 'public, max-age=86400');
    res.status(200).json(items);
  } catch (e: any) {
    res.status(500).json({ error: e?.message || 'Internal error' });
  }
}
