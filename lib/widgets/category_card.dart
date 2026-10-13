import 'package:flutter/material.dart';
import '../models/template_model.dart';
import '../theme/app_theme.dart';

/// Widget kartu untuk menampilkan satu kategori pada grid di halaman Beranda.
class CategoryCard extends StatelessWidget {
  final KategoriModel kategori;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.kategori,
    this.onTap,
  });

  /// Memetakan string nama ikon dari data JSON ke Icons Flutter bawaan.
  /// Sesuai spesifikasi docs/CONTEXT.md: school, event_busy, groups, campaign, description, warning.
  IconData _mapIkonToFlutter(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school;
      case 'event_busy':
        return Icons.event_busy;
      case 'groups':
        return Icons.groups;
      case 'campaign':
        return Icons.campaign;
      case 'description':
        return Icons.description;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusCard),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusCard),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wadah lingkaran/persegi melengkung untuk ikon kategori
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _mapIkonToFlutter(kategori.ikon),
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              // Nama kategori pesan
              Text(
                kategori.nama,
                style: AppTheme.judulKartu,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
