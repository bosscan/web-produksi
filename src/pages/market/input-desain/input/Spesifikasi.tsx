import { Box, Button, Grid, Typography, TextField, Select, MenuItem, Alert } from '@mui/material'
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useEffect } from 'react';

export default function InputSpesifikasi() {
    const navigate = useNavigate();

    const [nameDesign, setNameDesign] = useState('');
    const [sample, setSample] = useState('');
    const [product, setProduct] = useState('');
    const [pattern, setPattern] = useState('');
    const [fabric, setFabric] = useState('');
    const [fabricColor, setFabricColor] = useState('')
    const [colorCombination, setColorCombination] = useState('')
    const [codeColor, setCodeColor] = useState('')
    const [options, setOptions] = useState<Record<string, Array<{ value: string; label: string }>>>({})
    const [optionsError, setOptionsError] = useState<string>('')

    // Minimal offline defaults so dropdowns still usable if API is down
    const DEFAULT_OPTIONS: Record<string, Array<{ value: string; label: string }>> = {
        sample: [
            { value: 'ADA', label: 'Ada' },
            { value: 'TIDAK', label: 'Tidak' },
        ],
        jenis_produk: [
            { value: 'KAOS', label: 'Kaos' },
            { value: 'JAKET', label: 'Jaket' },
            { value: 'CELANA', label: 'Celana' },
            { value: 'KEMEJA', label: 'Kemeja' },
            { value: 'POLO', label: 'Polo' },
        ],
        jenis_pola: [
            { value: 'KAOS', label: 'Kaos' },
            { value: 'POLO', label: 'Polo' },
            { value: 'PDH', label: 'PDH' },
            { value: 'TACTICAL', label: 'Tactical' },
        ],
        jenis_kain: [
            { value: 'AMERICAN_DRILL', label: 'American Drill' },
            { value: 'NAGATA_DRILL', label: 'Nagata Drill' },
            { value: 'COMBED_30S', label: 'Combed 30S' },
        ],
    }

        // Load form data and dropdown options on mount
    useEffect(() => {
                const savedData = localStorage.getItem('inputDetailForm');
                if (savedData) {
                        const parsedData = JSON.parse(savedData);
                        setNameDesign(parsedData.nameDesign || '');
                        setSample(parsedData.sample || '');
                        setProduct(parsedData.product || '');
                        setPattern(parsedData.pattern || '');
                        setFabric(parsedData.fabric || '');
                        setFabricColor(parsedData.fabricColor || '');
                        setColorCombination(parsedData.colorCombination || '');
                        setCodeColor(parsedData.codeColor || '');
                }
                // Fetch dropdown enums
                (async () => {
                    try {
                        const res = await fetch('/api/dropdown/options');
                        if (!res.ok) throw new Error('HTTP '+res.status);
                        const optList = await res.json();
                        const byKey: Record<string, Array<{ value: string; label: string }>> = {};
                        (optList || []).forEach((o: any) => {
                            if (!o?.attribute) return;
                            const arr = byKey[o.attribute] || [];
                            arr.push({ value: o.value, label: o.label || o.value });
                            byKey[o.attribute] = arr;
                        });
                        setOptions(byKey);
                        setOptionsError('');
                        // cache
                        try { localStorage.setItem('dropdown_options_cache', JSON.stringify(byKey)); } catch {}
                    } catch (err) {
                        // Fallback to cache or defaults
                        try {
                            const raw = localStorage.getItem('dropdown_options_cache');
                            if (raw) {
                                setOptions(JSON.parse(raw));
                                setOptionsError('Gagal memuat pilihan, gunakan data cache.');
                                return;
                            }
                        } catch {}
                        setOptions(DEFAULT_OPTIONS);
                        setOptionsError('Gagal memuat pilihan, menggunakan pilihan default.');
                    }
                })();
    }, []);

    // Save form data to localStorage whenever it changes
    useEffect(() => {
        const formData = {
            nameDesign,
            sample,
            product,
            pattern,
            fabric,
            fabricColor,
            colorCombination,
            codeColor,
        };
        localStorage.setItem('inputDetailForm', JSON.stringify(formData));
    }, [nameDesign, sample, product, pattern, fabric, fabricColor, colorCombination, codeColor]);

    return (
        <Box sx={{
            display: 'flex',
            alignItems: 'center',
            width: '100%',
            maxHeight: 'calc(100vh - 64px)',
            overflowY: 'auto',
            alignItem: 'center',
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
            }}>
                <Typography variant="h6" sx={{ mb: 2, fontWeight: 'bold' }}>Spesifikasi Desain</Typography>
                {optionsError && (
                    <Alert severity="warning" sx={{ mb: 2 }}>
                        {optionsError}
                    </Alert>
                )}
                <Grid container spacing={3}>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 1 }}>Nama Desain :</Typography>
                            <TextField fullWidth variant='outlined' size='small' value={nameDesign} onChange={(e) => setNameDesign(e.target.value)} />
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 5 }}>Sample :</Typography>
                                                        <Select labelId='sample-select-label' size='small' value={sample} onChange={(e) => setSample(e.target.value)} fullWidth>
                                                                <MenuItem value=''>Pilih Sample</MenuItem>
                                                                {(options['sample'] || []).map(opt => (
                                                                    <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                                                ))}
                                                        </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 2 }}>Jenis Produk :</Typography>
                                                        <Select labelId='product-select-label' size='small' value={product} onChange={(e) => setProduct(e.target.value)} fullWidth>
                                                                <MenuItem value=''>Pilih Jenis Produk</MenuItem>
                                                                {(options['jenis_produk'] || []).map(opt => (
                                                                    <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                                                ))}
                                                        </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 2.5 }}>Jenis Pola :</Typography>
                                                        <Select labelId='pattern-select-label' size='small' value={pattern} onChange={(e) => setPattern(e.target.value)} fullWidth>
                                                                <MenuItem value=''>Pilih Jenis Pola</MenuItem>
                                                                {(options['jenis_pola'] || []).map(opt => (
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
                            <Typography variant='body1' sx={{ mr: 4.4 }}>Jenis Kain :</Typography>
                                                        <Select labelId='fabric-select-label' size='small' value={fabric} onChange={(e) => setFabric(e.target.value)} fullWidth>
                                                                <MenuItem value=''>Pilih Jenis Kain</MenuItem>
                                                                {(options['jenis_kain'] || []).map(opt => (
                                                                    <MenuItem key={opt.value} value={opt.value}>{opt.label}</MenuItem>
                                                                ))}
                                                        </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 1.7 }}>Warna Kain :</Typography>
                            <Select labelId='fabric-select-label' size='small' value={fabricColor} onChange={(e) => setFabricColor(e.target.value)} fullWidth>
                                <MenuItem value=''>Pilih Warna Kain</MenuItem>
                                <MenuItem value='kain1'>Warna 1</MenuItem>
                                <MenuItem value='kain2'>Warna 2</MenuItem>
                            </Select>
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 1 }}>Kombinasi Warna Kain :</Typography>
                            <TextField fullWidth size='small' value={colorCombination} onChange={(e) => setColorCombination(e.target.value)} />
                        </Box>
                    </Grid>
                    <Grid size={6}>
                        <Box
                            sx={{
                                display: 'flex',
                                alignItems: 'flex-start',
                            }}>
                            <Typography variant='body1' sx={{ mr: 1 }}>Kode Warna Kain :</Typography>
                            <TextField fullWidth size='small' value={codeColor} onChange={(e) => setCodeColor(e.target.value)} />
                        </Box>
                    </Grid>
                </Grid>
            </Box>
            <Box sx={{
                display: 'flex',
                justifyContent: 'space-between',
                mt: 2,
            }}>
                <Button variant='contained' size='medium' sx={{ mr: 65 }} onClick={() => navigate('/market/input-desain/antrian-input')}>Kembali</Button>
                <Button variant='contained' size='medium' onClick={() => navigate('/market/input-desain/input-detail')}>Selanjutnya</Button>
            </Box>
        </Box>
    )
}