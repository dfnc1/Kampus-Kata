# KampusKata 🎓

Katalog template pesan dan alasan sopan untuk berbagai situasi di kampus. Tugas UTS Mobile
Programming, Semester Ganjil 2025/2026.

**Nama:** Dian Febrian Nur Cahyo <br>
**NIM:** 240605110189 <br>
**Kelas:** Mobile Practicum J

## Tema dan Tujuan

Mahasiswa sering bingung merangkai kalimat yang tepat saat harus chat dosen, izin tidak masuk,
menagih teman kelompok, atau mengurus administrasi. KampusKata menyediakan template pesan siap pakai
yang sopan dan jujur, dikelompokkan per kategori, lengkap dengan tips kapan memakainya dan hal yang
sebaiknya dihindari.

## Halaman dan Fungsinya

| Halaman         | File                 | Fungsi                                                             |
|-----------------|----------------------|--------------------------------------------------------------------|
| Beranda         | `home_screen.dart`   | Sapaan, pencarian, grid kategori, dan template yang sering dipakai |
| Daftar Template | `list_screen.dart`   | Menampilkan daftar template berdasarkan kategori yang dipilih      |
| Detail Template | `detail_screen.dart` | Isi lengkap template, tingkat formalitas, tips, dan tombol Salin   |

## Fitur

- Navigasi antar halaman dengan `Navigator.push`
- Pencarian template
- Salin template ke clipboard dengan satu tap
- Data dari file JSON lokal dengan model class (`fromJson`), siap diganti ke API

## Struktur Proyek

```
lib/
├── main.dart
├── models/        # model data (TemplateModel)
├── services/      # pembaca data (JSON lokal, nanti bisa diganti API)
├── screens/       # halaman aplikasi
└── widgets/       # komponen yang dipakai ulang
assets/
├── data/templates.json
└── images/
```

## Cara Menjalankan

1. Pastikan Flutter SDK sudah terpasang (`flutter doctor`)
2. Clone repositori:

```bash
   git clone https://github.com/dfnc1/kampus-kata.git
   cd kampuskata
```

3. Install dependensi:

```bash
   flutter pub get
```

4. Jalankan di emulator atau perangkat:

```bash
   flutter run
```

## Rencana Pengembangan

- Mengganti sumber data dari JSON lokal ke API
- Fitur favorit dan riwayat template
- Mode gelap

## Catatan

Seluruh data pada aplikasi ini adalah data dummy untuk keperluan tugas.
