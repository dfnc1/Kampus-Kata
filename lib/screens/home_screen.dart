import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_model.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import '../widgets/template_card.dart';
import 'list_screen.dart';

/// Model internal untuk menampung kumpulan data halaman Beranda
class _HomeData {
  final List<KategoriModel> kategori;
  final List<TemplateModel> templates;

  _HomeData({required this.kategori, required this.templates});
}

/// Halaman Beranda aplikasi KampusKata.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Inisialisasi service penyedia data
  final DataService _dataService = DataService();

  // Variabel penampung Future data agar tidak dipanggil berulang saat setState()
  late Future<_HomeData> _homeDataFuture;

  // Indeks aktif untuk BottomNavigationBar
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Panggil pemuatan data ketika layar pertama kali diinisialisasi
    _homeDataFuture = _fetchHomeData();
  }

  /// Fungsi untuk mengambil data kategori dan template secara asynchronous dari DataService
  Future<_HomeData> _fetchHomeData() async {
    final kategoriList = await _dataService.getKategori();
    final templatesList = await _dataService.getTemplates();
    return _HomeData(kategori: kategoriList, templates: templatesList);
  }

  /// Fungsi untuk memuat ulang data saat tombol 'Coba Lagi' ditekan jika terjadi error
  void _refreshData() {
    setState(() {
      // setState memberitahu Flutter untuk merender ulang widget dengan Future yang baru
      _homeDataFuture = _fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _selectedIndex == 0
          ? _buildHomeBody()
          : _buildPlaceholderTab(_selectedIndex),
      // Navigasi bagian bawah: Beranda, Favorit, Tentang
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // setState memperbarui tab yang sedang dipilih
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }

  /// Membangun konten utama untuk tab Beranda
  Widget _buildHomeBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header navy melengkung dengan salam dan bilah pencarian
          _buildHeader(),

          const SizedBox(height: 16),

          // 2. FutureBuilder untuk menangani pengambilan data dari DataService
          // FutureBuilder adalah widget bawaan Flutter yang otomatis memperbarui tampilan
          // berdasarkan status Future (apakah masih menunggu/loading, error, atau sukses).
          FutureBuilder<_HomeData>(
            future: _homeDataFuture,
            builder: (context, snapshot) {
              // --- KONDISI LOADING ---
              // Jika data masih dalam proses dibaca dari JSON/aset
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                );
              }

              // --- KONDISI ERROR ---
              // Jika terjadi kesalahan koneksi atau berkas gagal diproses
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
                          'Gagal memuat data',
                          style: AppTheme.heading.copyWith(
                            color: AppTheme.dangerText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Terjadi kesalahan saat memuat template.',
                          style: AppTheme.caption,
                          textAlign: TextAlign.center,
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
              final data = snapshot.data;
              if (data == null || data.kategori.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.screenPadding),
                    child: Text(
                      'Tidak ada data kategori yang ditemukan.',
                      style: AppTheme.isi,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Bagian Kategori
                    Text('Kategori', style: AppTheme.heading),
                    const SizedBox(height: 12),

                    // Grid 2 kolom 6 kategori
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppTheme.cardSpacing,
                        mainAxisSpacing: AppTheme.cardSpacing,
                        childAspectRatio: 1.25,
                      ),
                      itemCount: data.kategori.length,
                      itemBuilder: (context, index) {
                        final kategori = data.kategori[index];
                        return CategoryCard(
                          kategori: kategori,
                          onTap: () {
                            // Navigasi ke ListScreen menggunakan Navigator.push
                            // Membawa nama kategori sebagai argumen parameter
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListScreen(kategori: kategori.nama),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Judul Bagian "Paling Sering Dipakai"
                    Text('Paling Sering Dipakai', style: AppTheme.heading),
                    const SizedBox(height: 12),

                    // Daftar kartu template paling sering dipakai (menampilkan 3 teratas)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.templates.take(3).length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppTheme.cardSpacing),
                      itemBuilder: (context, index) {
                        final template = data.templates[index];
                        return TemplateCard(
                          template: template,
                          onLihat: () {
                            // Tombol Lihat disiapkan, navigasi ke Detail di tahap selanjutnya
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Widget Header Navy melengkung di bagian atas
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: AppTheme.screenPadding,
        right: AppTheme.screenPadding,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teks salam utama
          Text(
            'Halo, Mahasiswa!',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Subjudul dengan aksen warna kuning
          Text(
            'Lagi butuh bilang apa?',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 16),
          // Search bar pencarian template
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari template pesan...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppTheme.textSecondary,
              ),
              filled: true,
              fillColor: AppTheme.cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSearchBar),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tampilan placeholder sederhana untuk tab Favorit & Tentang
  Widget _buildPlaceholderTab(int index) {
    final String title = index == 1 ? 'Favorit' : 'Tentang';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            index == 1 ? Icons.favorite_border : Icons.info_outline,
            size: 64,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTheme.heading),
          const SizedBox(height: 8),
          Text(
            'Halaman ini akan dikembangkan selanjutnya.',
            style: AppTheme.isi.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
