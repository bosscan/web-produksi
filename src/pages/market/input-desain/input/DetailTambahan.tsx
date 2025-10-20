import { Box, Button, Grid, Typography, TextField, Select, MenuItem, Modal, TableHead, TableContainer, Table, TableCell, TableRow, TableBody, Paper, FormControl, InputLabel, Snackbar, Alert } from '@mui/material'
import { useRef } from 'react'
import TableExportToolbar from '../../../../components/TableExportToolbar'
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import EditIcon from '@mui/icons-material/Edit';

interface Asset {
  file: string | null // Data URL for the file
  attribute: string
  size: string
  distance: string
  description: string
}

export default function DetailTambahan() {
  const tableRef = useRef<HTMLTableElement | null>(null)
    const navigate = useNavigate();

    const [bottomStrap, setBottomStrap] = useState('')
    const [armStrap, setArmStrap] = useState('')
    const [bottomTire, setBottomTire] = useState('')
    const [skoder, setSkoder] = useState('')
    const [pocketVariant, setPocketVariant] = useState('')
    const [reflector, setReflector] = useState('')
    const [colorReflector, setColorReflector] = useState('')
  const [ventilation, setVentilation] = useState('')
  const [jahitanVentilasiHorz, setJahitanVentilasiHorz] = useState('')
    const [penHolder, setPenHolder] = useState('')
    const [catTongue, setCatTongue] = useState('')
    const [lanyardHolder, setLanyardHolder] = useState('')
    const [HThanger, setHTHanger] = useState('')
  const [options, setOptions] = useState<Record<string, Array<{ value: string; label: string }>>>({})
  // Tambahan: Link Asset Desain & Catatan
  const [assetLink, setAssetLink] = useState('')
  const [catatan, setCatatan] = useState('')
  const [snack, setSnack] = useState<{ open: boolean; message: string; severity: 'success' | 'error' | 'info' }>({ open: false, message: '', severity: 'success' });

  // Load and persist tambahan form so it survives navigation and can be used by Print SPK
  useEffect(() => {
    try {
      const raw = localStorage.getItem('inputTambahanForm');
      if (raw) {
        const d = JSON.parse(raw);
        setBottomStrap(d.bottomStrap || '');
        setArmStrap(d.armStrap || '');
        setBottomTire(d.bottomTire || '');
        setSkoder(d.skoder || '');
        setPocketVariant(d.pocketVariant || '');
        setReflector(d.reflector || '');
        setColorReflector(d.colorReflector || '');
  setVentilation(d.ventilation || '');
  setJahitanVentilasiHorz(d.jahitanVentilasiHorz || '');
        setPenHolder(d.penHolder || '');
        setCatTongue(d.catTongue || '');
        setLanyardHolder(d.lanyardHolder || '');
        setHTHanger(d.HThanger || '');
      }
    } catch {}
    // Fetch dropdown enums for tambahan fields
    (async () => {
      try {
        const optList = await fetch('/api/dropdown/options').then(r => r.json()).catch(() => []);
        const byKey: Record<string, Array<{ value: string; label: string }>> = {};
        (optList || []).forEach((o: any) => {
          if (!o?.attribute || o.is_active === false) return;
          const arr = byKey[o.attribute] || [];
          arr.push({ value: o.value, label: o.label || o.value });
          byKey[o.attribute] = arr;
        });
        setOptions(byKey);
      } catch { setOptions({}); }
    })();
  }, []);
  useEffect(() => {
    try {
      const data = {
        bottomStrap, armStrap, bottomTire, skoder, pocketVariant, reflector, colorReflector, ventilation, jahitanVentilasiHorz, penHolder, catTongue, lanyardHolder, HThanger,
        // Store labels for printing
        bottomStrapLabel: (options['tali_bawah'] || []).find(o => o.value === bottomStrap)?.label || bottomStrap,
        armStrapLabel: (options['tali_lengan'] || []).find(o => o.value === armStrap)?.label || armStrap,
        bottomTireLabel: (options['ban_bawah'] || []).find(o => o.value === bottomTire)?.label || bottomTire,
        skoderLabel: (options['skoder'] || []).find(o => o.value === skoder)?.label || skoder,
        pocketVariantLabel: (options['varian_saku'] || []).find(o => o.value === pocketVariant)?.label || pocketVariant,
        reflectorLabel: reflector,
        colorReflectorLabel: (options['warna_list_reflektor'] || []).find(o => o.value === colorReflector)?.label || colorReflector,
        ventilationLabel: (options['ventilasi'] || []).find(o => o.value === ventilation)?.label || ventilation,
        penHolderLabel: (options['tempat_pulpen'] || []).find(o => o.value === penHolder)?.label || penHolder,
        catTongueLabel: (options['lidah_kucing'] || []).find(o => o.value === catTongue)?.label || catTongue,
        lanyardHolderLabel: (options['tempat_lanyard'] || []).find(o => o.value === lanyardHolder)?.label || lanyardHolder,
        HThangerLabel: (options['gantungan_ht'] || []).find(o => o.value === HThanger)?.label || HThanger,
      };
      localStorage.setItem('inputTambahanForm', JSON.stringify(data));
    } catch {}
  }, [bottomStrap, armStrap, bottomTire, skoder, pocketVariant, reflector, colorReflector, ventilation, penHolder, catTongue, lanyardHolder, HThanger, jahitanVentilasiHorz, options]);

  // Modal state
  const [addAssets, setAddAssets] = useState(false);
  const [editAssetIndex, setEditAssetIndex] = useState<number | null>(null);
  const [assets, setAssets] = useState<Asset[]>([]);
  const [newAsset, setNewAsset] = useState<Asset>({
    file: null,
    attribute: '',
    size: '',
    distance: '',
    description: '',
  });
  const [editAsset, setEditAsset] = useState<Asset>({
        file: null,
        attribute: '',
        size: '',
        distance: '',
        description: '',
    });

   // Handle file input change
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setNewAsset({ ...newAsset, file: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleEditFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (file) {
            const reader = new FileReader();
            reader.onloadend = () => {
                setEditAsset({ ...editAsset, file: reader.result as string });
            };
            reader.readAsDataURL(file);
        }
    };


  const handleDeleteAsset = (index: number) => {
    const asset = assets[index];
    if (asset) {
      setAssets(assets.filter((_, i) => i !== index));
    }
  };

      const handleEditAsset = (index: number) => {
        setEditAssetIndex(index);
        setEditAsset(assets[index]);
    };

    const handleSaveEditAsset = () => {
        if (editAssetIndex !== null) {
            const updatedAssets = [...assets];
            updatedAssets[editAssetIndex] = editAsset;
            setAssets(updatedAssets);
            setEditAssetIndex(null);
        }
    };

  // Handle saving new asset
  const handleSaveAsset = () => {
    if (newAsset.size && newAsset.distance && newAsset.description) {
      setAssets([...assets, newAsset]);
      setNewAsset({ file: null, attribute: '', size: '', distance: '', description: '' });
      setAddAssets(false);
    } else {
      alert('Please fill in all required fields.');
    }
  };

  // Finalize Input Desain -> push to design queue (localStorage)
  const handleSubmitToQueue = () => {
    try {
      const formRaw = localStorage.getItem('inputDetailForm');
      const form = formRaw ? JSON.parse(formRaw) : {};
      // Ambil konteks SPK untuk melekatkan idSpk dan quantity ke design_queue
      const spkRawCtx = localStorage.getItem('current_spk_context');
      const spkCtx = spkRawCtx ? JSON.parse(spkRawCtx) : null;
      const sanitizeQty = (val: any): string => {
        const n = Number(String(val ?? '').toString().replace(/[^\d-]/g, ''));
        return !isNaN(n) && n > 0 ? String(n) : '0';
      };
      // Helpers: generator 7-digit numeric IDs
      const nextCustomId = (): string => {
        const key = 'custom_auto_seq';
        let seq = parseInt(localStorage.getItem(key) || '5000000', 10);
        if (!Number.isFinite(seq) || seq < 5000000) seq = 5000000;
        seq += 1;
        localStorage.setItem(key, String(seq));
        return String(seq).padStart(7, '0');
      };
      const nextRekapIdForToday = (): string => {
        const today = new Date().toISOString().slice(0,10); // YYYY-MM-DD
        const dateKey = 'rekap_auto_date';
        const idKey = 'rekap_auto_id';
        const seqKey = 'rekap_auto_seq';
        const curDate = localStorage.getItem(dateKey) || '';
        if (curDate === today) {
          const existing = localStorage.getItem(idKey);
          if (existing && /^\d{7}$/.test(existing)) return existing;
        }
        let seq = parseInt(localStorage.getItem(seqKey) || '9000000', 10);
        if (!Number.isFinite(seq) || seq < 9000000) seq = 9000000;
        seq += 1;
        const id = String(seq).padStart(7, '0');
        localStorage.setItem(seqKey, String(seq));
        localStorage.setItem(dateKey, today);
        localStorage.setItem(idKey, id);
        return id;
      };
      const spkId = spkCtx?.idSpk || '';
      if (!spkId) {
        alert('ID SPK tidak ditemukan. Silakan pilih pesanan dari Antrian Input Desain terlebih dahulu.');
        return;
      }
      const spkQty = sanitizeQty(spkCtx?.quantity);
      // Generate IDs as requested
      const idRekapCustom = nextRekapIdForToday(); // 7-digit, start 9000001, one per day
      const idCustom = nextCustomId(); // 7-digit, start 5000001
      const item = {
        queueId: (crypto as any)?.randomUUID ? (crypto as any).randomUUID() : `${Date.now()}-${Math.random()}`,
        idRekapCustom,
        idCustom,
        idSpk: spkId,
        spkQuantity: spkQty,
        namaDesain: form.nameDesign || 'Desain Baru',
        jenisProduk: form.product || '-',
        jenisPola: form.pattern || '-',
        tanggalInput: new Date().toISOString().slice(0,10),
        namaCS: 'CS Marketing',
  assetLink: assetLink || '',
  catatan: catatan || '',
        assets: assets.map(a => ({ file: a.file, attribute: a.attribute, size: a.size, distance: a.distance, description: a.description })),
        status: 'Menunggu dikerjakan'
      };
      const key = 'design_queue';
      const raw = localStorage.getItem(key);
      const list = raw ? JSON.parse(raw) : [];
      list.push(item);
      localStorage.setItem(key, JSON.stringify(list));
      // Snapshot order and design details keyed by idSpk for Print SPK usage
      try {
        // 1) Persist original order (from antrian_input_desain)
        const qKey = 'antrian_input_desain';
        const qRaw2 = localStorage.getItem(qKey);
        const qList2 = qRaw2 ? JSON.parse(qRaw2) : [];
        const original = qList2.find((q: any) => String(q?.idSpk || '') === String(spkId));
        const orderMapKey = 'spk_orders';
        const orderMapRaw = localStorage.getItem(orderMapKey);
        const orderMap = orderMapRaw ? JSON.parse(orderMapRaw) : {};
        if (original) {
          orderMap[String(spkId)] = original;
          localStorage.setItem(orderMapKey, JSON.stringify(orderMap));
        }
  // 2) Persist design form snapshot keyed by idSpk
        const designMapKey = 'spk_design';
        const designMapRaw = localStorage.getItem(designMapKey);
        const designMap = designMapRaw ? JSON.parse(designMapRaw) : {};
  // merge product form, tambahan form and core form into a single snapshot for Print SPK
  const produkForm = JSON.parse(localStorage.getItem('inputProdukForm') || '{}');
  const tambahanForm = JSON.parse(localStorage.getItem('inputTambahanForm') || '{}');
  designMap[String(spkId)] = { ...form, ...produkForm, ...tambahanForm, assets, assetLink, catatan };
        localStorage.setItem(designMapKey, JSON.stringify(designMap));
      } catch {}
      // Remove this SPK from Antrian Input Desain and trigger refresh via storage event
      try {
        const qKey = 'antrian_input_desain';
        const qRaw = localStorage.getItem(qKey);
        const qList = qRaw ? JSON.parse(qRaw) : [];
        const filtered = qList.filter((q: any) => String(q?.idSpk || '') !== String(spkId));
        localStorage.setItem(qKey, JSON.stringify(filtered));
      } catch {}
      // Clear current context to avoid accidental reuse
      try { localStorage.removeItem('current_spk_context'); } catch {}
      // Tambahkan ke database_trend (via Input Desain) dengan quantity dari SPK terkait
      try {
        const trendKey = 'database_trend';
        const trendRaw = localStorage.getItem(trendKey);
  const trendList: Array<{ jenis_produk: string; jenis_pola: string; quantity: string; updatedAt: string; idSpk?: string }> = trendRaw ? JSON.parse(trendRaw) : [];
        const today = new Date().toISOString().slice(0,10);
        const jenisProduk = form.product || '-';
        const jenisPola = form.pattern || '-';
        // Ambil quantity dari SPK context yang diset saat klik Input Desain pada Antrian
        const spkRaw = localStorage.getItem('current_spk_context');
        const spk = spkRaw ? JSON.parse(spkRaw) : null;
        // Helper: sanitize a quantity-like value into a positive integer (as string)
        const sanitizeQty = (val: any): string => {
          const n = Number(String(val ?? '').toString().replace(/[^\d-]/g, ''));
          return !isNaN(n) && n > 0 ? String(n) : '';
        };
        // 1) Try quantity from current_spk_context
        let qtyStr = sanitizeQty(spk?.quantity);
        // 2) If missing, try to find the SPK in antrian_input_desain by id and read its quantity
        if (!qtyStr) {
          try {
            const queueRaw = localStorage.getItem('antrian_input_desain');
            const queue = queueRaw ? JSON.parse(queueRaw) : [];
            const found = spk?.idSpk ? queue.find((q: any) => q?.idSpk === spk.idSpk) : null;
            qtyStr = sanitizeQty(found?.quantity);
            // 3) As a last resort, use items length if available
            if (!qtyStr && found?.items) qtyStr = sanitizeQty(found.items.length);
          } catch {}
        }
        // Final fallback
        if (!qtyStr) qtyStr = '0';
  trendList.push({ jenis_produk: jenisProduk, jenis_pola: jenisPola, quantity: qtyStr, updatedAt: today, idSpk: spk?.idSpk });
        localStorage.setItem(trendKey, JSON.stringify(trendList));
      } catch {}
  setSnack({ open: true, message: `Input desain tersimpan (Rekap: ${idRekapCustom}). Mengarahkan ke Antrian Input Desain…`, severity: 'success' });
  // Optionally clear draft form // localStorage.removeItem('inputDetailForm');
  setTimeout(() => navigate('/market/input-desain/antrian-input'), 600);
    } catch (e) {
  setSnack({ open: true, message: 'Gagal menyimpan ke antrian desain.', severity: 'error' });
    }
  };

    return (
        <Box sx={{
            display: 'flex',
            alignItems: 'center',
            width: '100%',
            maxHeight: 'calc(100vh - 64px)',
            overflowY: 'auto',
            // alignItem: 'center',
            p: 3,
            boxSizing: 'border-box',
            flexDirection: 'column',
        }}>
            <Box sx={{
                width: '80%',
                height: '500',
                borderRadius: 2,
                boxShadow: 2,
                flexDirection: 'column',
                p: 3,
                mb: 3
            }}>
                <Typography variant="h6" sx={{ mb: 2, fontWeight: 'bold' }}>Detail Tambahan</Typography>
                <Grid container spacing={1}>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 10 }}>Tali Bawah :</Typography>
                            <Select labelId='product-select-label' size='small' value={bottomStrap} onChange={(e) => setBottomStrap(e.target.value)}>
                                <MenuItem value=''>Pilih Tali Bawah</MenuItem>
                                {(options['tali_bawah'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 7 }}>Tali Lengan :</Typography>
                            <Select labelId='sample-select-label' size='small' value={armStrap} onChange={(e) => setArmStrap(e.target.value)}>
                                <MenuItem value=''>Pilih Tali Lengan</MenuItem>
                                {(options['tali_lengan'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 9.7 }}>Ban Bawah :</Typography>
                            <Select labelId='product-select-label' size='small' value={bottomTire} onChange={(e) => setBottomTire(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Ban Bawah</MenuItem>
                                {(options['ban_bawah'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 11.1 }}>Skoder :</Typography>
                            <Select labelId='pattern-select-label' size='small' value={skoder} onChange={(e) => setSkoder(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Skoder</MenuItem>
                                {(options['skoder'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 9.2 }}>Varian Saku :</Typography>
                            <Select labelId='fabric-select-label' size='small' value={pocketVariant} onChange={(e) => setPocketVariant(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Varian Saku</MenuItem>
                                {(options['varian_saku'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 3.9 }}>Jenis Reflektor :</Typography>
                            <Select labelId='fabric-select-label' size='small' value={reflector} onChange={(e) => setReflector(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Reflektor</MenuItem>
                                {(options['jenis_reflektor'] && options['jenis_reflektor'].length > 0
                                  ? options['jenis_reflektor']
                                  : [
                                      { value: 'Reflektor 1', label: 'Reflektor 1' },
                                      { value: 'Reflektor 2', label: 'Reflektor 2' },
                                    ]
                                ).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 1.7 }}>Warna List Reflektor :</Typography>
                            <Select labelId='product-select-label' size='small' value={colorReflector} onChange={(e) => setColorReflector(e.target.value)}>
                                <MenuItem value=''>Pilih Warna List Reflektor</MenuItem>
                                {(options['warna_list_reflektor'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 9.7 }}>Ventilasi :</Typography>
                            <Select labelId='product-select-label' size='small' value={ventilation} onChange={(e) => setVentilation(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Ventilasi</MenuItem>
                                {(options['ventilasi'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
          <Grid size={6}>
            <Box
              sx={{
                display: 'flex',
                alignItems: 'center',
              }}>
              <Typography variant='body1' sx={{ mr: 1.9 }}>Jahitan Ventilasi Horz :</Typography>
              <Select labelId='product-select-label' size='small' value={jahitanVentilasiHorz} onChange={(e) => setJahitanVentilasiHorz(e.target.value)}>
                <MenuItem value=''>Pilih Jahitan Ventilasi Horz</MenuItem>
                {(options['jahitan_ventilasi_horz'] || [
                  { value: 'JAHITAN_1', label: 'Jahitan 1' },
                  { value: 'JAHITAN_2', label: 'Jahitan 2' }
                ]).map(opt => (
                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                ))}
              </Select>
            </Box>
          </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 6.3 }}>Tempat Pulpen :</Typography>
                            <Select labelId='product-select-label' size='small' value={penHolder} onChange={(e) => setPenHolder(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Tempat Pulpen</MenuItem>
                                {(options['tempat_pulpen'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 5.8 }}>Lidah Kucing :</Typography>
                            <Select labelId='product-select-label' size='small' value={catTongue} onChange={(e) => setCatTongue(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Lidah Kucing</MenuItem>
                                {(options['lidah_kucing'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 5.4 }}>Tempat Lanyard :</Typography>
                            <Select labelId='product-select-label' size='small' value={lanyardHolder} onChange={(e) => setLanyardHolder(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Tempat Lanyard</MenuItem>
                                {(options['tempat_lanyard'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'center',
                            }}>
                            <Typography variant='body1' sx={{ mr: 4.5 }}>Gantungan HT :</Typography>
                            <Select labelId='product-select-label' size='small' value={HThanger} onChange={(e) => setHTHanger(e.target.value)}>
                                <MenuItem value=''>Pilih Jenis Gantungan HT</MenuItem>
                                {(options['gantungan_ht'] || []).map(opt => (
                                  <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                ))}
                            </Select>
                        </Box>
                    </Grid>
                </Grid>
            </Box>

            {/* Atribut */}
            <Box sx={{
                width: '80%',
                height: '500',
                borderRadius: 2,
                boxShadow: 2,
                display: 'flex',
                alignItems: 'flex-start',
                flexDirection: 'column',
                p: 3,
                mb: 3
            }}>
                <Typography variant='body1' sx={{ mb: 1, fontWeight: 'bold' }} >Atribut</Typography>
                <Button variant='outlined' onClick={() => setAddAssets(true)}>Tambahkan</Button>
                {assets.length > 0 ? (<>
                  <TableExportToolbar title='Atribut Desain' tableRef={tableRef} fileBaseName='atribut-desain' />
                  <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="assets table" ref={tableRef}>
              <TableHead>
                <TableRow>
                  <TableCell>Preview</TableCell>
                  <TableCell>Bagian Atribut</TableCell>
                  <TableCell>Ukuran</TableCell>
                  <TableCell>Jarak</TableCell>
                  <TableCell>Keterangan</TableCell>
                  <TableCell>Edit</TableCell>
                  <TableCell>Hapus</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {assets.map((asset, index) => (
                  <TableRow key={index}>
                    {/* preview image */}
                    <TableCell>
                      {asset.file ? (
                        <img src={asset.file} style={{ maxWidth: '100px', maxHeight: '100px' }} />
                      ) : (
                        'No Image'
                      )}
                    </TableCell>
                    <TableCell>{asset.attribute}</TableCell>
                    <TableCell>{asset.size}</TableCell>
                    <TableCell>{asset.distance}</TableCell>
                    <TableCell>{asset.description}</TableCell>
                    <TableCell><Button onClick={() => handleEditAsset(index)}><EditIcon /></Button></TableCell>
                    <TableCell><Button color="error" onClick={() => handleDeleteAsset(index)}>Hapus</Button></TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer></>) : (<Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
            Belum ada aset ditambahkan.
          </Typography>)}
          <Modal
          open={addAssets}
          onClose={() => setAddAssets(false)}
          sx={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}
        >
          <Box
            sx={{
              bgcolor: 'background.paper',
              p: 5,
              borderRadius: 2,
              boxShadow: 24,
              maxHeight: 650,
              maxWidth: 800,
              flexDirection: 'column'
            }}
          >
            <Typography variant="h6" sx={{ mb: 2, fontWeight: 'bold' }}>
              Tambah File
            </Typography>
            <Grid container spacing={2}>
              <Grid size={3}>
                <Button variant="outlined" component="label" fullWidth size='medium'>
                  Upload File
                  <input
                    type="file"
                    accept="image/*"
                    hidden
                    onChange={handleFileChange}
                  />
                </Button>
                {newAsset.file && (
                  <Box sx={{ mt: 2 }}>
                    <img
                      src={newAsset.file}
                      alt="Preview"
                      style={{ maxWidth: '100px', maxHeight: '100px' }}
                    />
                  </Box>
                )}
              </Grid>
              <Grid size={3}>
                <FormControl sx={{ minWidth: 160 }} size='small'>
                  <InputLabel id='atribut'> Bagian Atribut
                  </InputLabel>
                  <Select
                  labelId='bagian-atribut'
                  id='bagian-attribut'
                  value={newAsset.attribute}
                  onChange={(e) => setNewAsset({ ...newAsset, attribute: e.target.value })}>
                    <MenuItem value=''>Pilih Bagian Atribut</MenuItem>
                    <MenuItem value='Dada Kanan'>Dada Kanan</MenuItem>
                    <MenuItem value='Dada Kiri'>Dada Kiri</MenuItem>
                    <MenuItem value='Lengan Kanan'>Lengan Kanan</MenuItem>
                    <MenuItem value='Lengan Kiri'>Lengan Kiri</MenuItem>
                    <MenuItem value='Belakang'>Belakang</MenuItem>
                    <MenuItem value='Tambahan'>Tambahan</MenuItem>
                    <MenuItem value='Referensi'>Referensi</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
              <Grid size={3}>
                <TextField
                  fullWidth
                  variant="outlined"
                  size="small"
                  label="Ukuran"
                  value={newAsset.size}
                  onChange={(e) => setNewAsset({ ...newAsset, size: e.target.value })}
                  required
                />
              </Grid>
              <Grid size={3}>
                <TextField
                  fullWidth
                  variant="outlined"
                  size="small"
                  label="Jarak"
                  value={newAsset.distance}
                  onChange={(e) => setNewAsset({ ...newAsset, distance: e.target.value })}
                  required
                />
              </Grid>
              <Grid size={3}>
                <TextField
                  fullWidth
                  variant="outlined"
                  size="small"
                  label="Keterangan"
                  value={newAsset.description}
                  onChange={(e) => setNewAsset({ ...newAsset, description: e.target.value })}
                  multiline
                  rows={1}
                  required
                />
              </Grid>
              <Grid size={3}>
                <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 2 }}>
                  <Button variant="outlined" onClick={() => setAddAssets(false)}>
                    Batal
                  </Button>
                  <Button variant="contained" onClick={handleSaveAsset}>
                    Simpan
                  </Button>
                </Box>
              </Grid>
            </Grid>
          </Box>
        </Modal>

        <Modal
                    open={editAssetIndex !== null}
                    onClose={() => setEditAssetIndex(null)}
                    sx={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}
                >
                    <Box
                        sx={{
                            bgcolor: 'background.paper',
                            p: 5,
                            borderRadius: 2,
                            boxShadow: 24,
                            maxHeight: 600,
                            maxWidth: 800,
                            flexDirection: 'column'
                        }}
                    >
                        <Typography variant="h6" sx={{ mb: 2, fontWeight: 'bold' }}>
                            Edit File
                        </Typography>
                        <Grid container spacing={2}>
                            <Grid size={3}>
                                <Button variant="outlined" component="label" fullWidth size='small'>
                                    Upload File
                                    <input
                                        type="file"
                                        accept="image/*"
                                        hidden
                                        onChange={handleEditFileChange}
                                    />
                                </Button>
                                {editAsset.file && (
                                    <Box sx={{ mt: 2 }}>
                                        <img
                                            src={editAsset.file}
                                            alt="Preview"
                                            style={{ maxWidth: '100px', maxHeight: '100px' }}
                                        />
                                    </Box>
                                )}
                            </Grid>
                            <Grid size={3}>
                                <TextField
                                    fullWidth
                                    variant="outlined"
                                    size="small"
                                    label="Ukuran"
                                    value={editAsset.size}
                                    onChange={(e) => setEditAsset({ ...editAsset, size: e.target.value })}
                                    required
                                />
                            </Grid>
                            <Grid size={3}>
                                <TextField
                                    fullWidth
                                    variant="outlined"
                                    size="small"
                                    label="Jarak"
                                    value={editAsset.distance}
                                    onChange={(e) => setEditAsset({ ...editAsset, distance: e.target.value })}
                                    required
                                />
                            </Grid>
                            <Grid size={3}>
                                <TextField
                                    fullWidth
                                    variant="outlined"
                                    size="small"
                                    label="Keterangan"
                                    value={editAsset.description}
                                    onChange={(e) => setEditAsset({ ...editAsset, description: e.target.value })}
                                    multiline
                                    rows={1}
                                    required
                                />
                            </Grid>
                            <Grid size={12}>
                                <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 2, mt: 2 }}>
                                    <Button variant="outlined" onClick={() => setEditAssetIndex(null)}>
                                        Batal
                                    </Button>
                                    <Button variant="contained" onClick={handleSaveEditAsset}>
                                        Simpan Perubahan
                                    </Button>
                                </Box>
                            </Grid>
                        </Grid>
                    </Box>
                </Modal>
            </Box>

            {/* Link Asset Desain & Catatan */}
            <Box sx={{
                width: '80%',
                height: '500',
                borderRadius: 2,
                boxShadow: 2,
                flexDirection: 'column',
                p: 3,
            }}>
                <Typography variant='body1' sx={{ mb: 1, fontWeight: 'bold' }} >Link Asset Desain</Typography>
                <TextField
                  fullWidth
                  variant='outlined'
                  size='small'
                  placeholder='https://drive.google.com/… atau URL lain'
                  value={assetLink}
                  onChange={(e)=> setAssetLink(e.target.value)}
                  sx={{ mb: 2 }}
                />
                <Typography variant='body1' sx={{ mb: 1, fontWeight: 'bold' }} >Catatan</Typography>
                <TextField
                  fullWidth
                  variant='outlined'
                  size='small'
                  multiline
                  value={catatan}
                  onChange={(e)=> setCatatan(e.target.value)}
                />
            </Box>
            <Box sx={{
                display: 'flex',
                justifyContent: 'space-between',
                mt: 2,
            }}>
                <Button variant='contained' size='medium' sx={{ mr: 65 }} onClick={() => navigate('/market/input-desain/input-detail')}>Kembali</Button>
                <Button variant='contained' size='medium' color='primary' onClick={handleSubmitToQueue}>Simpan & Kirim ke Antrian</Button>

            </Box>
            <Snackbar
              open={snack.open}
              autoHideDuration={2500}
              onClose={() => setSnack(s => ({ ...s, open: false }))}
              anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
            >
              <Alert onClose={() => setSnack(s => ({ ...s, open: false }))} severity={snack.severity} variant="filled" sx={{ width: '100%' }}>
                {snack.message}
              </Alert>
            </Snackbar>
        </Box>
    )
}