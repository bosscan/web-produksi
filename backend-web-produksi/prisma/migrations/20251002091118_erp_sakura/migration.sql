-- CreateEnum
CREATE TYPE "JenisProduk" AS ENUM ('KAOS', 'JAKET', 'CELANA', 'KEMEJA', 'POLO');

-- CreateEnum
CREATE TYPE "JenisPola" AS ENUM ('KAOS', 'POLO', 'PDH', 'TACTICAL', 'TACTICAL_GASENDRA', 'TACTICAL_KJ', 'SAFETY', 'PETROSEA', 'BERAU', 'ADARO', 'KPC_2_WARNA', 'GRASBERG');

-- CreateEnum
CREATE TYPE "JenisKain" AS ENUM ('AMERICAN_DRILL', 'NAGATA_DRILL', 'TEXMOODA', 'BABY_CANVAS', 'TASLAN_BALOON', 'TASLAN_MILKY', 'COMBED_30S', 'COMBED_24S', 'LACOSTE_PE', 'LACOSTE_COTTTON');

-- CreateEnum
CREATE TYPE "Hoodie" AS ENUM ('PATEN', 'LEPAS_PASANG');

-- CreateEnum
CREATE TYPE "SakuBawah" AS ENUM ('TIDAK', 'TANPA_ZIPPER', 'PAKAI_ZIPPER');

-- CreateEnum
CREATE TYPE "TaliBawah" AS ENUM ('TIDAK', 'PAKAI_TALI');

-- CreateEnum
CREATE TYPE "SakuFuring" AS ENUM ('TIDAK', 'KANAN_KIRI', 'KANAN', 'KIRI');

-- CreateEnum
CREATE TYPE "UjungLengan" AS ENUM ('TIDAK', 'VELCRO', 'KERUT_VELCRO', 'KERUT', 'MANSET', 'MANSET_PENDEK', 'MANSET_BUR');

-- CreateEnum
CREATE TYPE "Aplikasi" AS ENUM ('TIDAK', 'BORDIR', 'SABLON', 'KOMBINASI');

-- CreateEnum
CREATE TYPE "JenisBordir" AS ENUM ('TIDAK', 'LANGUNG', 'TIMBUL', 'BADGE');

-- CreateEnum
CREATE TYPE "WarnaListReflektor" AS ENUM ('TIDAK', 'HIJAU_STABILO', 'KUNING_STABILO', 'ORANGE_STABILO', 'MERAH', 'BIRU');

-- CreateEnum
CREATE TYPE "Plaket" AS ENUM ('TIDAK', 'KNOP_DALAM', 'KNOP_LUAR', 'VELCRO');

-- CreateEnum
CREATE TYPE "PotonganBawah" AS ENUM ('LURUS', 'LENGKUNG');

-- CreateEnum
CREATE TYPE "Skoder" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "Saku" AS ENUM ('STANDAR_POLA', 'GELEMBUNG', 'DALAM', 'TEMPEL');

-- CreateEnum
CREATE TYPE "VariasiSaku" AS ENUM ('TIDAK', 'HIDUP', 'MATI', 'STANDAR_POLA');

-- CreateEnum
CREATE TYPE "KancingDepan" AS ENUM ('LUAR', 'DALAM', 'ZIPPER_LUAR', 'ZIPPER_DALAM', 'ZIPPER_PLAKET');

-- CreateEnum
CREATE TYPE "TaliLengan" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "Ventilasi" AS ENUM ('TIDAK', 'PAKAI', 'VERTIKAL', 'HORIZONTAL', 'KETIAK', 'VERT_KETIAK', 'HORZ_KETIAK');

-- CreateEnum
CREATE TYPE "TempatPulpen" AS ENUM ('TIDAK', 'SAKU_KANAN', 'SAKU_KIRI', 'LENGAN_KANAN', 'LENGAN_KIRI', 'KOMBINASI');

-- CreateEnum
CREATE TYPE "LidahKucing" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "BanBawah" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "Kerah" AS ENUM ('TEGAK', 'STANDAR', 'O_NECK', 'V_NECK', 'SHANGHAI', 'JADI', 'BIKIN');

-- CreateEnum
CREATE TYPE "BelahanSamping" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "JenisSablon" AS ENUM ('DTF', 'RUBBER', 'PLASTISOL', 'KOMBINASI');

-- CreateEnum
CREATE TYPE "TempatLanyard" AS ENUM ('TIDAK', 'PAKAI');

-- CreateEnum
CREATE TYPE "GantunganHT" AS ENUM ('TIDAK', 'DADA_KIRI', 'DADA_KANAN', 'LENGAN_KIRI', 'LENGAN_KANAN');

-- CreateEnum
CREATE TYPE "Sample" AS ENUM ('ADA', 'TIDAK');

-- CreateEnum
CREATE TYPE "StatusDesain" AS ENUM ('SELESAI', 'ANTRIAN_REVISI', 'DESAIN_DIVALIDASI', 'PENDING');

-- CreateEnum
CREATE TYPE "ActionDesain" AS ENUM ('REVISI', 'VALIDASI');

-- CreateEnum
CREATE TYPE "StatusPesanan" AS ENUM ('DESAIN_PRODUKSI', 'CUTTING_POLA', 'STOCK_BORDIR', 'BORDIR', 'SETTING', 'STOCK_JAHIT', 'JAHIT', 'FINISHING', 'FOTO_PRODUK', 'STOCK_NT', 'PELUNASAN', 'PENGIRIMAN');

-- CreateEnum
CREATE TYPE "StatusPraProduksi" AS ENUM ('SELESAI', 'BELUM_SELESAI');

-- CreateEnum
CREATE TYPE "StatusProduksi" AS ENUM ('PENDING', 'SUDAH_DIKERJAKAN');

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_konsumen" (
    "id" SERIAL NOT NULL,
    "nama_pemesan" TEXT NOT NULL,
    "alamat" TEXT NOT NULL,
    "provinsi" TEXT NOT NULL,
    "kabupaten" TEXT NOT NULL,
    "kecamatan" TEXT NOT NULL,
    "desa" TEXT NOT NULL,
    "nomer_hp" INTEGER NOT NULL,
    "konten" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "data_konsumen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_pesanan" (
    "id" SERIAL NOT NULL,
    "id_pemesan" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "tipe_transaksi" TEXT NOT NULL,
    "nominal_transaksi" DOUBLE PRECISION NOT NULL,
    "bukti_transaksi" BYTEA NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "data_pesanan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "list_pesanan" (
    "id" SERIAL NOT NULL,
    "id_data_pesanan" INTEGER NOT NULL,
    "size" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "format_nama" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "list_pesanan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_input_desain" (
    "id" SERIAL NOT NULL,
    "id_cs" INTEGER NOT NULL,
    "id_pemesan" INTEGER NOT NULL,
    "id_data_pesanan" INTEGER NOT NULL,
    "no_spk" TEXT NOT NULL,
    "nama_pemesan" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "tipe_transaksi" TEXT NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "tanggal_input_pesanan" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_input_desain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "input_desain" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "no_spk" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "sample" "Sample" NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "jenis_kain" "JenisKain" NOT NULL,
    "warna_kain" TEXT NOT NULL,
    "kombinasi_warna" TEXT NOT NULL,
    "kode_warna" TEXT NOT NULL,
    "aplikasi" "Aplikasi" NOT NULL,
    "jenis_bordir" "JenisBordir" NOT NULL,
    "jenis_sablon" "JenisSablon" NOT NULL,
    "hoodie" "Hoodie" NOT NULL,
    "potongan_bawah" "PotonganBawah" NOT NULL,
    "belahan_samping" "BelahanSamping" NOT NULL,
    "kerah" "Kerah" NOT NULL,
    "plaket" "Plaket" NOT NULL,
    "saku" "Saku" NOT NULL,
    "saku_bawah" "SakuBawah" NOT NULL,
    "saku_furing" "SakuFuring" NOT NULL,
    "ujung_lengan" "UjungLengan" NOT NULL,
    "kancing_depan" "KancingDepan" NOT NULL,
    "tali_tambahan" TEXT NOT NULL,
    "tali_lengan" "TaliLengan" NOT NULL,
    "ban_bawah" "BanBawah" NOT NULL,
    "skoder" "Skoder" NOT NULL,
    "varian_saku" "VariasiSaku" NOT NULL,
    "jenis_reflektor" TEXT NOT NULL,
    "warna_list_reflektor" "WarnaListReflektor" NOT NULL,
    "ventilasi" "Ventilasi" NOT NULL,
    "tempat_pulpen" "TempatPulpen" NOT NULL,
    "lidah_kucing" "LidahKucing" NOT NULL,
    "tempat_lanyard" "TempatLanyard" NOT NULL,
    "gantungan_ht" "GantunganHT" NOT NULL,
    "atribut_dada_kanan" BYTEA NOT NULL,
    "ukuran_dada_kanan" INTEGER NOT NULL,
    "jarak_dada_kanan" TEXT NOT NULL,
    "keterangan_dada_kanan" TEXT NOT NULL,
    "atribut_dada_kiri" BYTEA NOT NULL,
    "ukuran_dada_kiri" INTEGER NOT NULL,
    "jarak_dada_kiri" TEXT NOT NULL,
    "keterangan_dada_kiri" TEXT NOT NULL,
    "atribut_lengan_kanan" BYTEA NOT NULL,
    "ukuran_lengan_kanan" INTEGER NOT NULL,
    "jarak_lengan_kanan" TEXT NOT NULL,
    "keterangan_lengan_kanan" TEXT NOT NULL,
    "atribut_lengan_kiri" BYTEA NOT NULL,
    "ukuran_lengan_kiri" INTEGER NOT NULL,
    "jarak_lengan_kiri" TEXT NOT NULL,
    "keterangan_lengan_kiri" TEXT NOT NULL,
    "atribut_belakang" BYTEA NOT NULL,
    "ukuran_belakang" INTEGER NOT NULL,
    "jarak_belakang" TEXT NOT NULL,
    "keterangan_belakang" TEXT NOT NULL,
    "atribut_tambahan" BYTEA NOT NULL,
    "ukuran_tambahan" INTEGER NOT NULL,
    "jarak_tambahan" TEXT NOT NULL,
    "keterangan_tambahan" TEXT NOT NULL,
    "atribut_referensi" BYTEA NOT NULL,
    "ukuran_referensi" INTEGER NOT NULL,
    "jarak_referensi" TEXT NOT NULL,
    "keterangan_referensi" TEXT NOT NULL,
    "catatan" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "input_desain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_pengerjaan_desain" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_desain" INTEGER NOT NULL,
    "id_cs" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "no_spk" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "tanggal_input_desain" TIMESTAMP(3) NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "status_desain" "StatusDesain" NOT NULL DEFAULT 'PENDING',
    "view_mockup" BYTEA NOT NULL,
    "action" "ActionDesain" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_pengerjaan_desain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "keranjang" (
    "id" SERIAL NOT NULL,
    "id_data_pesanan" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "nama_konsumen" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "selected" BOOLEAN NOT NULL DEFAULT false,
    "checked_out_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "keranjang_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "list_cpk_on_proses" (
    "id" SERIAL NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "jumlah_spk" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "status" "StatusPesanan" NOT NULL,
    "status_konten" TEXT NOT NULL,
    "tanggal_input_pesanan" TIMESTAMP(3) NOT NULL,
    "deadline_konsumen" TIMESTAMP(3) NOT NULL,
    "tanggal_spk_terbit" TIMESTAMP(3) NOT NULL,
    "selesai_plotting_produksi" TIMESTAMP(3),
    "selesai_desain_produksi" TIMESTAMP(3),
    "selesai_cutting_pola" TIMESTAMP(3),
    "selesai_stock_bordir" TIMESTAMP(3),
    "selesai_bordir" TIMESTAMP(3),
    "selesai_setting" TIMESTAMP(3),
    "selesai_stock_jahit" TIMESTAMP(3),
    "selesai_jahit" TIMESTAMP(3),
    "selesai_foto_produk" TIMESTAMP(3),
    "selesai_stock_NT" TIMESTAMP(3),
    "selesai_pelunasan" TIMESTAMP(3),
    "selesai_pengiriman" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "list_cpk_on_proses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "database_konsumen" (
    "id_data_konsumen" INTEGER NOT NULL,
    "nama" TEXT NOT NULL,
    "telepon" INTEGER NOT NULL,
    "alamat" TEXT NOT NULL,
    "tanggal_input" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "database_konsumen_pkey" PRIMARY KEY ("id_data_konsumen","nama","telepon","alamat","tanggal_input")
);

-- CreateTable
CREATE TABLE "database_trend" (
    "id" SERIAL NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "database_trend_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plotting_rekap_bordir" (
    "id" SERIAL NOT NULL,
    "id_checkout_batch" INTEGER NOT NULL,
    "id_data_pesanan" INTEGER NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_rekap_produksi" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "jumlah_spk" INTEGER NOT NULL,
    "no_spk" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "status_desain" "StatusDesain" NOT NULL,
    "status_pesanan" "StatusPesanan" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "plotting_rekap_bordir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "list_rekap_bordir" (
    "id" SERIAL NOT NULL,
    "id_checkout_batch" INTEGER NOT NULL,
    "id_plotting_rekap_bordir" INTEGER NOT NULL,
    "id_rekap_bordir" TEXT NOT NULL,
    "jumlah_spk" INTEGER NOT NULL,
    "list_spk" TEXT NOT NULL,
    "quantity_spk" INTEGER NOT NULL,
    "total_quantity" INTEGER NOT NULL,
    "antrian_input_desainId" INTEGER,
    "antrian_pengerjaan_desainId" INTEGER,

    CONSTRAINT "list_rekap_bordir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_pengerjaan_desain_pra_produksi" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input_desain" TIMESTAMP(3) NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "asset_desain" INTEGER NOT NULL,
    "kerjakan" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "antrian_pengerjaan_desain_pra_produksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_pengerjaan_revisi_desain_pra_produksi" (
    "id" SERIAL NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input_desain" TIMESTAMP(3) NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "asset_desain" INTEGER NOT NULL,
    "detail_revisi" TEXT NOT NULL,
    "kerjakan" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "antrian_pengerjaan_revisi_desain_pra_produksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_desain_produksi" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_desain_produksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_cutting_pola" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_cutting_pola_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_stock_bordir" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_stock_bordir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_bordir" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusDesain" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_bordir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_setting" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_setting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_stock_jahit" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_stock_jahit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_jahit" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_jahit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_finishing" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_finishing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_foto_produk" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_foto_produk_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_stock_nomer_transaksi" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_stock_nomer_transaksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_pengiriman" (
    "id" SERIAL NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "id_transaksi" TEXT NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input" TEXT NOT NULL,
    "kuantity" INTEGER,
    "status" "StatusPraProduksi" NOT NULL DEFAULT 'BELUM_SELESAI',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_pengiriman_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_pendapatan" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3),
    "slot_dp" INTEGER,
    "omset_dp" INTEGER,
    "slot_pelunasan" INTEGER,
    "slot_dpl" INTEGER,
    "omset_dpl" DOUBLE PRECISION,
    "slot_kumulatif" DOUBLE PRECISION,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "konsolidasi_date_key" TEXT,

    CONSTRAINT "report_pendapatan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_maintenance_mesin" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "mesin" TEXT NOT NULL,
    "pekerjaan" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "note" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_maintenance_mesin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_overhead_pabrik" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "kategori" TEXT NOT NULL,
    "uraian" TEXT NOT NULL,
    "nominal" DOUBLE PRECISION NOT NULL,
    "catatan" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_overhead_pabrik_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_gaji" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "karyawan" TEXT NOT NULL,
    "divisi" TEXT NOT NULL,
    "gaji_pokok" DOUBLE PRECISION NOT NULL,
    "lembur" DOUBLE PRECISION NOT NULL,
    "bonus" DOUBLE PRECISION NOT NULL,
    "potongan" DOUBLE PRECISION NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_gaji_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_belanja_logistik" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "kategori" TEXT NOT NULL,
    "uraian" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "harga" DOUBLE PRECISION NOT NULL,
    "catatan" TEXT,
    "total" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_belanja_logistik_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_fee_jaringan" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "partner" TEXT NOT NULL,
    "uraian" TEXT NOT NULL,
    "nominal" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_fee_jaringan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_biaya_marketing" (
    "id" SERIAL NOT NULL,
    "channel" TEXT NOT NULL,
    "campaign" TEXT NOT NULL,
    "pengeluaran" DOUBLE PRECISION NOT NULL,
    "catatan" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_biaya_marketing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pengeluaran_ongkir" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "ekspedisi" TEXT NOT NULL,
    "no_resi" TEXT NOT NULL,
    "tujuan" TEXT NOT NULL,
    "nominal" DOUBLE PRECISION NOT NULL,
    "catatan" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pengeluaran_ongkir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "konsolidasi" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "total_pendapatan" DOUBLE PRECISION NOT NULL,
    "total_pengeluaran" DOUBLE PRECISION NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "konsolidasi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "database_produk" (
    "id" SERIAL NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_antrian_input_desain" INTEGER NOT NULL,
    "id_spk" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "foto" BYTEA NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "database_produk_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "database_sebaran" (
    "id" SERIAL NOT NULL,
    "kecamatan" TEXT NOT NULL,
    "kabupaten" TEXT NOT NULL,
    "provinsi" TEXT NOT NULL,
    "jumlah_konsumen" INTEGER NOT NULL,
    "total_pesanan" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "database_sebaran_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_pra_produksi" (
    "id" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input_desain" TIMESTAMP(3) NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "asset_desain" INTEGER NOT NULL,
    "status" "StatusProduksi" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_pra_produksi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "antrian_revisi_pra_produksi" (
    "id" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_antrian_pengerjaan_desain" INTEGER NOT NULL,
    "id_input_desain" INTEGER NOT NULL,
    "id_rekap_custom" TEXT NOT NULL,
    "id_custom" TEXT NOT NULL,
    "id_spk" TEXT NOT NULL,
    "nama_desain" TEXT NOT NULL,
    "jenis_produk" "JenisProduk" NOT NULL,
    "jenis_pola" "JenisPola" NOT NULL,
    "tanggal_input_desain" TIMESTAMP(3) NOT NULL,
    "nama_cs" TEXT NOT NULL,
    "revisi_catatan" TEXT,
    "status" "StatusProduksi" NOT NULL DEFAULT 'PENDING',
    "link_drive_input_cs" "StatusPraProduksi" NOT NULL,
    "link_drive_asset_jadi" TEXT,
    "catatan" TEXT,
    "worksheet" BYTEA,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "antrian_revisi_pra_produksi_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "user_nama_key" ON "user"("nama");

-- CreateIndex
CREATE UNIQUE INDEX "user_cs" ON "user"("id", "nama");

-- CreateIndex
CREATE UNIQUE INDEX "data_konsumen_nama_pemesan_key" ON "data_konsumen"("nama_pemesan");

-- CreateIndex
CREATE UNIQUE INDEX "data_konsumen_unique" ON "data_konsumen"("id", "nama_pemesan");

-- CreateIndex
CREATE UNIQUE INDEX "data_konsumen_all" ON "data_konsumen"("id", "nama_pemesan", "nomer_hp", "alamat", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "data_pesanan_tipe_created" ON "data_pesanan"("id", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "data_pesanan_antrian" ON "data_pesanan"("id", "quantity", "tipe_transaksi", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "data_pesanan_keranjang" ON "data_pesanan"("id", "quantity");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_input_desain_pesanan" ON "antrian_input_desain"("quantity", "tanggal_input_pesanan");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_input_desain_pemesan" ON "antrian_input_desain"("nama_pemesan");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_input_desain_cs" ON "antrian_input_desain"("nama_cs");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_input_desain_spk" ON "antrian_input_desain"("id", "no_spk");

-- CreateIndex
CREATE UNIQUE INDEX "spesifikasi_desain_nama" ON "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola");

-- CreateIndex
CREATE UNIQUE INDEX "spesifikasi_desain_created_at" ON "input_desain"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "spesifikasi_desain_nama_created_at" ON "input_desain"("id", "nama_desain", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "input_desain_id_nama_desain_created_at_jenis_pola_jenis_pro_key" ON "input_desain"("id", "nama_desain", "created_at", "jenis_pola", "jenis_produk");

-- CreateIndex
CREATE UNIQUE INDEX "spesifikasi_desain_jenis" ON "input_desain"("id", "jenis_produk", "jenis_pola");

-- CreateIndex
CREATE UNIQUE INDEX "input_desain_id_nama_desain_key" ON "input_desain"("id", "nama_desain");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_pengerjaan_desain_rekap" ON "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom");

-- CreateIndex
CREATE INDEX "keranjang_checked_out_at_idx" ON "keranjang"("checked_out_at");

-- CreateIndex
CREATE INDEX "keranjang_selected_checked_out_at_idx" ON "keranjang"("selected", "checked_out_at");

-- CreateIndex
CREATE UNIQUE INDEX "keranjang_id" ON "keranjang"("id");

-- CreateIndex
CREATE INDEX "plotting_rekap_bordir_nama_desain_idx" ON "plotting_rekap_bordir"("nama_desain");

-- CreateIndex
CREATE UNIQUE INDEX "plotting_rekap_bordir_id_key" ON "plotting_rekap_bordir"("id");

-- CreateIndex
CREATE UNIQUE INDEX "report_pendapatan_date_key" ON "report_pendapatan"("date");

-- CreateIndex
CREATE INDEX "database_sebaran_kecamatan_kabupaten_provinsi_idx" ON "database_sebaran"("kecamatan", "kabupaten", "provinsi");

-- CreateIndex
CREATE UNIQUE INDEX "antrian_revisi_pra_produksi_unique" ON "antrian_revisi_pra_produksi"("id_rekap_custom", "id_custom");

-- AddForeignKey
ALTER TABLE "data_pesanan" ADD CONSTRAINT "data_pesanan_id_pemesan_fkey" FOREIGN KEY ("id_pemesan") REFERENCES "data_konsumen"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_pesanan" ADD CONSTRAINT "list_pesanan_id_data_pesanan_fkey" FOREIGN KEY ("id_data_pesanan") REFERENCES "data_pesanan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_input_desain" ADD CONSTRAINT "antrian_input_desain_id_data_pesanan_quantity_tipe_transak_fkey" FOREIGN KEY ("id_data_pesanan", "quantity", "tipe_transaksi", "tanggal_input_pesanan") REFERENCES "data_pesanan"("id", "quantity", "tipe_transaksi", "created_at") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_input_desain" ADD CONSTRAINT "antrian_input_desain_id_pemesan_nama_pemesan_fkey" FOREIGN KEY ("id_pemesan", "nama_pemesan") REFERENCES "data_konsumen"("id", "nama_pemesan") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_input_desain" ADD CONSTRAINT "antrian_input_desain_id_cs_nama_cs_fkey" FOREIGN KEY ("id_cs", "nama_cs") REFERENCES "user"("id", "nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "input_desain" ADD CONSTRAINT "input_desain_id_antrian_input_desain_no_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "no_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain" ADD CONSTRAINT "antrian_pengerjaan_desain_id_antrian_input_desain_no_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "no_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain" ADD CONSTRAINT "antrian_pengerjaan_desain_id_desain_nama_desain_tanggal_in_fkey" FOREIGN KEY ("id_desain", "nama_desain", "tanggal_input_desain") REFERENCES "input_desain"("id", "nama_desain", "created_at") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain" ADD CONSTRAINT "antrian_pengerjaan_desain_id_cs_nama_cs_fkey" FOREIGN KEY ("id_cs", "nama_cs") REFERENCES "user"("id", "nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keranjang" ADD CONSTRAINT "keranjang_id_data_pesanan_quantity_fkey" FOREIGN KEY ("id_data_pesanan", "quantity") REFERENCES "data_pesanan"("id", "quantity") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keranjang" ADD CONSTRAINT "keranjang_id_antrian_pengerjaan_desain_id_rekap_custom_id__fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keranjang" ADD CONSTRAINT "keranjang_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keranjang" ADD CONSTRAINT "keranjang_id_input_desain_nama_desain_fkey" FOREIGN KEY ("id_input_desain", "nama_desain") REFERENCES "input_desain"("id", "nama_desain") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "database_konsumen" ADD CONSTRAINT "database_konsumen_id_data_konsumen_nama_telepon_alamat_tan_fkey" FOREIGN KEY ("id_data_konsumen", "nama", "telepon", "alamat", "tanggal_input") REFERENCES "data_konsumen"("id", "nama_pemesan", "nomer_hp", "alamat", "created_at") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "database_trend" ADD CONSTRAINT "database_trend_id_input_desain_jenis_produk_jenis_pola_fkey" FOREIGN KEY ("id_input_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plotting_rekap_bordir" ADD CONSTRAINT "plotting_rekap_bordir_id_data_pesanan_quantity_fkey" FOREIGN KEY ("id_data_pesanan", "quantity") REFERENCES "data_pesanan"("id", "quantity") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plotting_rekap_bordir" ADD CONSTRAINT "plotting_rekap_bordir_id_input_desain_nama_desain_fkey" FOREIGN KEY ("id_input_desain", "nama_desain") REFERENCES "input_desain"("id", "nama_desain") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plotting_rekap_bordir" ADD CONSTRAINT "plotting_rekap_bordir_id_antrian_input_desain_no_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "no_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plotting_rekap_bordir" ADD CONSTRAINT "plotting_rekap_bordir_id_antrian_pengerjaan_desain_id_reka_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_rekap_bordir" ADD CONSTRAINT "list_rekap_bordir_id_plotting_rekap_bordir_fkey" FOREIGN KEY ("id_plotting_rekap_bordir") REFERENCES "plotting_rekap_bordir"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_rekap_bordir" ADD CONSTRAINT "list_rekap_bordir_antrian_input_desainId_fkey" FOREIGN KEY ("antrian_input_desainId") REFERENCES "antrian_input_desain"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_rekap_bordir" ADD CONSTRAINT "list_rekap_bordir_antrian_pengerjaan_desainId_fkey" FOREIGN KEY ("antrian_pengerjaan_desainId") REFERENCES "antrian_pengerjaan_desain"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_desain_pra_produksi_id_antrian_input_de_fkey" FOREIGN KEY ("id_antrian_input_desain") REFERENCES "antrian_input_desain"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_desain_pra_produksi_id_antrian_pengerja_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_desain_pra_produksi_id_input_desain_nam_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "tanggal_input_desain", "jenis_pola", "jenis_produk") REFERENCES "input_desain"("id", "nama_desain", "created_at", "jenis_pola", "jenis_produk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_desain_pra_produksi_id_user_nama_cs_fkey" FOREIGN KEY ("id_user", "nama_cs") REFERENCES "user"("id", "nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_revisi_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_revisi_desain_pra_produksi_id_antrian_p_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_revisi_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_revisi_desain_pra_produksi_id_input_des_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "tanggal_input_desain", "jenis_pola", "jenis_produk") REFERENCES "input_desain"("id", "nama_desain", "created_at", "jenis_pola", "jenis_produk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengerjaan_revisi_desain_pra_produksi" ADD CONSTRAINT "antrian_pengerjaan_revisi_desain_pra_produksi_id_user_nama_fkey" FOREIGN KEY ("id_user", "nama_cs") REFERENCES "user"("id", "nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_desain_produksi" ADD CONSTRAINT "antrian_desain_produksi_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_desain_produksi" ADD CONSTRAINT "antrian_desain_produksi_id_antrian_pengerjaan_desain_id_re_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_desain_produksi" ADD CONSTRAINT "antrian_desain_produksi_id_input_desain_nama_desain_jenis__fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_cutting_pola" ADD CONSTRAINT "antrian_cutting_pola_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_cutting_pola" ADD CONSTRAINT "antrian_cutting_pola_id_antrian_pengerjaan_desain_id_rekap_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_cutting_pola" ADD CONSTRAINT "antrian_cutting_pola_id_input_desain_nama_desain_jenis_pro_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_bordir" ADD CONSTRAINT "antrian_stock_bordir_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_bordir" ADD CONSTRAINT "antrian_stock_bordir_id_antrian_pengerjaan_desain_id_rekap_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_bordir" ADD CONSTRAINT "antrian_stock_bordir_id_input_desain_nama_desain_jenis_pro_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_bordir" ADD CONSTRAINT "antrian_bordir_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_bordir" ADD CONSTRAINT "antrian_bordir_id_antrian_pengerjaan_desain_id_rekap_custo_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_bordir" ADD CONSTRAINT "antrian_bordir_id_input_desain_nama_desain_jenis_produk_je_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_setting" ADD CONSTRAINT "antrian_setting_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_setting" ADD CONSTRAINT "antrian_setting_id_antrian_pengerjaan_desain_id_rekap_cust_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_setting" ADD CONSTRAINT "antrian_setting_id_input_desain_nama_desain_jenis_produk_j_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_jahit" ADD CONSTRAINT "antrian_stock_jahit_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_jahit" ADD CONSTRAINT "antrian_stock_jahit_id_antrian_pengerjaan_desain_id_rekap__fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_jahit" ADD CONSTRAINT "antrian_stock_jahit_id_input_desain_nama_desain_jenis_prod_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_jahit" ADD CONSTRAINT "antrian_jahit_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_jahit" ADD CONSTRAINT "antrian_jahit_id_antrian_pengerjaan_desain_id_rekap_custom_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_jahit" ADD CONSTRAINT "antrian_jahit_id_input_desain_nama_desain_jenis_produk_jen_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_finishing" ADD CONSTRAINT "antrian_finishing_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_finishing" ADD CONSTRAINT "antrian_finishing_id_antrian_pengerjaan_desain_id_rekap_cu_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_finishing" ADD CONSTRAINT "antrian_finishing_id_input_desain_nama_desain_jenis_produk_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_foto_produk" ADD CONSTRAINT "antrian_foto_produk_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_foto_produk" ADD CONSTRAINT "antrian_foto_produk_id_antrian_pengerjaan_desain_id_rekap__fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_foto_produk" ADD CONSTRAINT "antrian_foto_produk_id_input_desain_nama_desain_jenis_prod_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_nomer_transaksi" ADD CONSTRAINT "antrian_stock_nomer_transaksi_id_antrian_input_desain_id_s_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_nomer_transaksi" ADD CONSTRAINT "antrian_stock_nomer_transaksi_id_antrian_pengerjaan_desain_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_stock_nomer_transaksi" ADD CONSTRAINT "antrian_stock_nomer_transaksi_id_input_desain_nama_desain__fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengiriman" ADD CONSTRAINT "antrian_pengiriman_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengiriman" ADD CONSTRAINT "antrian_pengiriman_id_antrian_pengerjaan_desain_id_rekap_c_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pengiriman" ADD CONSTRAINT "antrian_pengiriman_id_input_desain_nama_desain_jenis_produ_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "jenis_produk", "jenis_pola") REFERENCES "input_desain"("id", "nama_desain", "jenis_produk", "jenis_pola") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "database_produk" ADD CONSTRAINT "database_produk_id_antrian_input_desain_id_spk_fkey" FOREIGN KEY ("id_antrian_input_desain", "id_spk") REFERENCES "antrian_input_desain"("id", "no_spk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "database_produk" ADD CONSTRAINT "database_produk_id_input_desain_nama_desain_fkey" FOREIGN KEY ("id_input_desain", "nama_desain") REFERENCES "input_desain"("id", "nama_desain") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pra_produksi" ADD CONSTRAINT "antrian_pra_produksi_id_antrian_pengerjaan_desain_id_rekap_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pra_produksi" ADD CONSTRAINT "antrian_pra_produksi_id_user_nama_cs_fkey" FOREIGN KEY ("id_user", "nama_cs") REFERENCES "user"("id", "nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_pra_produksi" ADD CONSTRAINT "antrian_pra_produksi_id_input_desain_nama_desain_tanggal_i_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "tanggal_input_desain") REFERENCES "input_desain"("id", "nama_desain", "created_at") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_revisi_pra_produksi" ADD CONSTRAINT "antrian_revisi_pra_produksi_id_antrian_pengerjaan_desain_i_fkey" FOREIGN KEY ("id_antrian_pengerjaan_desain", "id_rekap_custom", "id_custom") REFERENCES "antrian_pengerjaan_desain"("id", "id_rekap_custom", "id_custom") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_revisi_pra_produksi" ADD CONSTRAINT "antrian_revisi_pra_produksi_nama_cs_fkey" FOREIGN KEY ("nama_cs") REFERENCES "user"("nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "antrian_revisi_pra_produksi" ADD CONSTRAINT "antrian_revisi_pra_produksi_id_input_desain_nama_desain_ta_fkey" FOREIGN KEY ("id_input_desain", "nama_desain", "tanggal_input_desain") REFERENCES "input_desain"("id", "nama_desain", "created_at") ON DELETE RESTRICT ON UPDATE CASCADE;
