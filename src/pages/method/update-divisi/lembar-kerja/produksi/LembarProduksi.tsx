import { Box, Typography, Paper, TableContainer, TableHead, TableRow, TableCell, Table, Card, CardContent, TableBody, Checkbox, Button, Modal, Snackbar, Alert } from "@mui/material";
import { useEffect, useMemo, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { markSelesai } from "../../../../../lib/pipelineHelpers";

export default function LembarProduksi() {
    const [checked, setChecked] = useState(false);
    const [open, setOpen] = useState(false);
    const [snack, setSnack] = useState<{ open: boolean; message: string; severity: 'success' | 'error' | 'info' }>({ open: false, message: '', severity: 'success' });
    const { search } = useLocation();
    const navigate = useNavigate();
    const spkId = useMemo(() => {
        const p = new URLSearchParams(search);
        return (p.get('spk') || '').trim();
    }, [search]);

    useEffect(() => {
        // optional: preload any data using spkId if needed
    }, [spkId]);

    const handleConfirm = async () => {
        try {
            const updated = await markSelesai(spkId, 'selesai_desain_produksi', 'selesaiDesainProduksi');
            setOpen(false);
            setSnack({ open: true, message: updated ? 'Status divisi Desainer Produksi diset selesai. Diteruskan ke antrian.' : 'ID SPK tidak ditemukan.', severity: updated ? 'success' : 'info' });
            if (updated) setTimeout(() => navigate('/method/update-divisi/produksi/antrian'), 600);
        } catch {
            setOpen(false);
            setSnack({ open: true, message: 'Terjadi kesalahan saat menyimpan.', severity: 'error' });
        }
    };

    return (
        <Box sx={{
            display: 'flex',
            alignItems: 'center',
            width: '100%',
            maxHeight: 'calc(100vh - 64px)',
            overflowY: 'auto',
            // alignItem is a no-op; alignItems above handles centering
            p: 3,
            boxSizing: 'border-box',
            flexDirection: 'column',
        }}>
            <Box sx={{
                width: '100%',
                height: 'auto',
                display: 'flex',
                borderRadius: 2,
                boxShadow: 2,
                flexDirection: 'column',
                alignItems: 'center',
                p: 3,
                mb: 3
            }}>
                {/* Title centered */}
                <Typography variant="h6" fontWeight={700} align="center" sx={{ width: '100%' }}>
                    Lembar Kerja Divisi Produksi {spkId ? `(SPK: ${spkId})` : ''}
                </Typography>

                {/* Content row: mockup on the left, table on the right */}
                <Box
                    sx={{
                        mt: 2,
                        width: '100%',
                        display: 'flex',
                        flexDirection: { xs: 'column', md: 'row' },
                        gap: 2,
                        alignItems: 'stretch',
                        justifyContent: 'center',
                    }}
                >
                    {/* Left: View Mockup */}
                    <Box sx={{ width: { xs: '100%', md: 350, lg: 400 } }}>
                        <Card>
                            <CardContent>
                                <Typography variant="body1" fontWeight={600}>View Mockup:</Typography>
                                {/* Placeholder for mockup image */}
                                <Box
                                    sx={{
                                        mt: 1,
                                        width: '100%',
                                        height: 300,
                                        backgroundColor: '#f0f0f0',
                                        border: '1px solid #ccc',
                                        borderRadius: 1,
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                    }}
                                >
                                    <Typography variant="caption" color="textSecondary">
                                        Mockup Image Here
                                    </Typography>
                                </Box>
                                <Typography variant="body2" align="center" fontWeight={600} sx={{ mt: 1,  }}> Spesifikasi Produk </Typography>
                                <Typography variant="body2" align="left" sx={{ mt: 1 }}> Jenis Produk :  </Typography>
                                <Typography variant="body2" align="left" sx={{ mt: 1 }}> Jenis Pola :  </Typography>
                                <Typography variant="body2" align="left" sx={{ mt: 1 }}> Jenis Kain :  </Typography>
                                <Typography variant="body2" align="left" sx={{ mt: 1 }}> Warna Kain :  </Typography>
                                <Typography variant="body2" align="left" sx={{ mt: 1 }}> Warna Kombinasi Kain :  </Typography>
                            </CardContent>
                        </Card>
                    </Box>

                    {/* Right: Table with constrained width */}
                    <Box sx={{ width: { xs: '100%', md: 480 }, ml: { xs: 0, md: 2} }}>
                        <TableContainer component={Paper} sx={{ width: '100%' }}>
                            <Table
                                aria-label="lembar-produksi"
                                size="small"
                                sx={{
                                    '& .MuiTableCell-root': { py: 0.5, px: 1, fontSize: '0.875rem' },
                                }}
                            >
                                <TableHead>
                                    <TableRow>
                                        <TableCell>No.</TableCell>
                                        <TableCell>Size</TableCell>
                                        <TableCell>Format Nama</TableCell>
                                        <TableCell>Checkbox</TableCell>
                                    </TableRow>
                                </TableHead>
                                <TableBody>
                                    <TableRow>
                                        <TableCell>1</TableCell>
                                        <TableCell>Small</TableCell>
                                        <TableCell>Format A</TableCell>
                                        <TableCell>
                                            <Checkbox
                                                checked={checked}
                                                onChange={(_, v) => setChecked(v)}
                                                inputProps={{ 'aria-label': 'pilih baris 1' }}
                                            />
                                        </TableCell>
                                    </TableRow>
                                </TableBody>
                            </Table>
                        </TableContainer>
                    </Box>
                </Box>
                <Button
                    variant="contained"
                    color="primary"
                    sx={{ mt: 3 }}
                    disabled={!checked}
                    onClick={() => setOpen(true)}
                >
                    Selesai
                </Button>

                {/* Confirmation Modal */}
                <Modal
                    open={open}
                    onClose={() => setOpen(false)}
                    aria-labelledby="konfirmasi-title"
                    aria-describedby="konfirmasi-desc"
                >
                    <Box
                        sx={{
                            position: 'absolute',
                            top: '50%',
                            left: '50%',
                            transform: 'translate(-50%, -50%)',
                            width: { xs: '90%', sm: 420 },
                            bgcolor: 'background.paper',
                            borderRadius: 2,
                            boxShadow: 24,
                            p: 3,
                            outline: 'none',
                        }}
                    >
                        <Typography id="konfirmasi-title" variant="h6" fontWeight={700} gutterBottom>
                            Konfirmasi
                        </Typography>
                        <Typography id="konfirmasi-desc" variant="body2" color="text.secondary">
                            Apakah Anda yakin sudah selesai mengerjakan dan sudah di cek semua dengan teliti?
                        </Typography>

                        <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 1.5, mt: 3 }}>
                            <Button color="error" onClick={() => setOpen(false)} variant="outlined">
                                Tidak yakin
                            </Button>
                            <Button onClick={handleConfirm} color="primary" variant="contained">
                                Yakin
                            </Button>
                        </Box>
                    </Box>
                </Modal>
            </Box>
            <Snackbar open={snack.open} autoHideDuration={2500} onClose={() => setSnack(s => ({ ...s, open: false }))} anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}>
                <Alert onClose={() => setSnack(s => ({ ...s, open: false }))} severity={snack.severity} variant="filled" sx={{ width: '100%' }}>
                    {snack.message}
                </Alert>
            </Snackbar>
        </Box>
    )
}