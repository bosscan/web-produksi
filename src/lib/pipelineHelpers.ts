import Api from './api';

/**
 * Mark a pipeline item as finished for given division.
 * Tries backend first, then falls back to localStorage('spk_pipeline').
 * @param spkId idSpk string
 * @param backendField snake_case field for backend (e.g., 'selesai_cutting_pola')
 * @param localField camelCase field in localStorage object (e.g., 'selesaiCuttingPola')
 * @returns true if any update was applied; false otherwise
 */
export async function markSelesai(spkId: string, backendField: string, localField: string): Promise<boolean> {
  const id = (spkId || '').trim();
  if (!id) return false;
  let updated = false;
  try {
    await Api.markPipeline(id, backendField);
    updated = true;
  } catch {
    // ignore, try local fallback
  }
  try {
    const raw = localStorage.getItem('spk_pipeline');
    const list: any[] = raw ? JSON.parse(raw) : [];
    const now = new Date().toISOString();
    for (const it of list) {
      if ((it?.idSpk || '').trim() === id) {
        if (!it[localField]) {
          it[localField] = now;
          updated = true;
        }
      }
    }
    if (updated) localStorage.setItem('spk_pipeline', JSON.stringify(list));
  } catch {
    // ignore storage errors
  }
  return updated;
}

export default { markSelesai };
