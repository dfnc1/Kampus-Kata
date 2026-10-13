# KampusKata: Konteks Proyek

Tugas UTS Mobile Programming (Flutter). Aplikasi katalog template pesan
sopan untuk situasi di kampus (chat dosen, izin, tugas kelompok, dll).
Data dummy dari JSON lokal, struktur harus siap diganti ke API nanti.

## Aturan Kerja (WAJIB)
- Kerjakan SATU tahap per perintah, jangan loncat ke tahap lain.
- Setelah selesai, jelaskan singkat file apa yang dibuat dan fungsinya.
- Beri komentar bahasa Indonesia di bagian penting (navigasi, FutureBuilder,
  fromJson, setState). Kode harus mudah dipahami mahasiswa pemula.
- Hanya pakai widget standar Flutter (Scaffold, AppBar, Column, Row,
  Container, GridView, ListView.builder, Card, Chip, TextField,
  BottomNavigationBar, FutureBuilder, Navigator.push, SnackBar).
- Package tambahan hanya `google_fonts`. Jangan tambah package lain.
- Jangan ubah struktur `assets/data/templates.json` dan model yang sudah ada.
- Jangan pakai state management (Provider, Bloc, dll). Cukup StatefulWidget.
- Jangan buat fitur di luar yang diminta.

## Struktur Folder
lib/
  main.dart
  models/template_model.dart     (KategoriModel, TemplateModel)
  services/data_service.dart     (baca JSON; satu-satunya sumber data)
  screens/home_screen.dart, list_screen.dart, detail_screen.dart
  widgets/category_card.dart, template_card.dart
  theme/app_theme.dart
assets/data/templates.json

## Desain
- Warna: navy #1E3A5F (utama), kuning #FFC93C (aksen), krem #FFF8E7
  (background), putih #FFFFFF (kartu), teks #1F2937, teks sekunder #6B7280,
  bahaya: background #FDECEC, teks #B91C1C.
- Font: Poppins (google_fonts). Judul 22 bold, heading 16 semibold,
  judul kartu 14 semibold, isi 14 regular, caption 12.
- Radius 16 untuk kartu dan tombol, 24 untuk chip dan search bar.
- Padding layar 16, jarak antar kartu 12. Flat, tanpa gradasi.
- Semua teks UI dalam bahasa Indonesia.

## Halaman
1. Beranda: header navy melengkung ("Halo, Mahasiswa!", "Lagi butuh bilang
   apa?"), search bar, grid 2 kolom 6 kategori, daftar "Paling Sering
   Dipakai", BottomNavigationBar (Beranda, Favorit, Tentang).
2. Daftar: AppBar judul nama kategori, filter chip (Semua/Formal/Santai),
   ListView kartu template + tombol "Lihat".
3. Detail: AppBar + ikon favorit, judul, chip kategori dan formalitas,
   kartu isi pesan, kartu "Kapan dipakai", "Tips", "Jangan Dilakukan"
   (merah muda), tombol kuning "Salin Template" (Clipboard + SnackBar).

## Skema Data (templates.json)
{ "kategori": [ {id, nama, ikon} ],
  "templates": [ {id, judul, kategori, tingkat_formal, isi, tips,
                  kapan_dipakai, jangan_dilakukan} ] }
Field `ikon` berupa teks (school, event_busy, groups, campaign,
description, warning), dipetakan ke Icons.* dengan switch.
Template terhubung ke kategori lewat nama kategori (string).

