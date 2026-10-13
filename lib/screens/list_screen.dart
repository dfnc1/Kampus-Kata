import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_model.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/template_card.dart';

/// Halaman Daftar: Menampilkan daftar template berdasarkan kategori yang dipilih.
/// Memiliki filter chip (Semua / Formal / Santai) menggunakan StatefulWidget dan setState.
class ListScreen extends StatefulWidget {
  // Nama kategori yang dikirim dari halaman sebelumnya melalui parameter konstruktor
  final String kategori;

  const ListScreen({
    super.key,
    required this.kategori,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Service untuk mengambil data template dari berkas JSON
  final DataService _dataService = DataService();

  // Future untuk menampung proses asynchronous pengambilan data template
  late Future<List<TemplateModel>> _templatesFuture;

  // State untuk menyimpan opsi filter yang sedang aktif (Semua / Formal / Santai)
  String _selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    // Memulai pemanggilan data template sesuai kategori saat layar dibuka
    _templatesFuture = _dataService.getTemplatesByKategori(widget.kategori);
  }

  /// Fungsi untuk memuat ulang data saat terjadi error
  void _refreshData() {
    setState(() {
      // setState memicu pembuatan ulang Future dan memperbarui tampilan antarmuka (UI)
      _templatesFuture = _dataService.getTemplatesByKategori(widget.kategori);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      // AppBar dengan judul sesuai nama kategori yang dipilih
      appBar: AppBar(
        title: Text(widget.kategori),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Baris Filter Chip: Semua, Formal, Santai
          _buildFilterChips(),

          // 2. Daftar Template dengan FutureBuilder
          Expanded(
            child: FutureBuilder<List<TemplateModel>>(
              future: _templatesFuture,
              builder: (context, snapshot) {
                // --- KONDISI LOADING ---
                // Ditampilkan saat data masih dalam proses dibaca dari data_service
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  );
                }

                // --- KONDISI ERROR ---
                // Ditampilkan jika terjadi kegagalan saat membaca data
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.screenPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppTheme.dangerText,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gagal memuat template',
                            style: AppTheme.heading.copyWith(
                              color: AppTheme.dangerText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Terjadi kesalahan saat membaca berkas data.',
                            style: AppTheme.caption,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _refreshData,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // --- KONDISI SUKSES / DATA TERSEDIA ---
                final allTemplates = snapshot.data ?? [];

                // Filter data berdasarkan tingkat formalitas yang dipilih
                final filteredList = allTemplates.where((template) {
                  if (_selectedFilter == 'Semua') return true;
                  return template.tingkatFormal.toLowerCase() ==
                      _selectedFilter.toLowerCase();
                }).toList();

                // Jika tidak ada template yang sesuai dengan filter
                if (filteredList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.screenPadding),
                      child: Text(
                        'Tidak ada template dengan kategori "${widget.kategori}" dan tingkat "$_selectedFilter".',
                        style: AppTheme.isi.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                // Menampilkan daftar kartu template menggunakan ListView.separated
                return ListView.separated(
                  padding: const EdgeInsets.all(AppTheme.screenPadding),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppTheme.cardSpacing),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return TemplateCard(
                      template: item,
                      onLihat: () {
                        // Tombol aksi "Lihat" sudah disiapkan untuk navigasi Detail di Tahap 4
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun baris pilihan filter chip: Semua, Formal, Santai
  Widget _buildFilterChips() {
    final List<String> filterOptions = ['Semua', 'Formal', 'Santai'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.screenPadding,
        AppTheme.screenPadding,
        AppTheme.screenPadding,
        4,
      ),
      child: Row(
        children: filterOptions.map((filter) {
          final bool isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              selectedColor: AppTheme.accentColor,
              backgroundColor: AppTheme.cardColor,
              labelStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: AppTheme.textPrimary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusChip),
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.accentColor
                      : const Color(0xFFE5E7EB),
                ),
              ),
              showCheckmark: false,
              onSelected: (selected) {
                if (selected) {
                  // setState() memberitahu framework Flutter bahwa nilai _selectedFilter telah berubah,
                  // sehingga method build() akan dipanggil ulang dan menyaring daftar data sesuai filter baru.
                  setState(() {
                    _selectedFilter = filter;
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
