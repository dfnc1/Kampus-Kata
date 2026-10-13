import 'package:flutter/material.dart';
import '../models/template_model.dart';
import '../theme/app_theme.dart';

/// Widget kartu untuk menampilkan satu template pesan dalam daftar.
/// Digunakan pada halaman Beranda (Paling Sering Dipakai) dan ListScreen.
class TemplateCard extends StatelessWidget {
  final TemplateModel template;
  final VoidCallback? onLihat;

  const TemplateCard({
    super.key,
    required this.template,
    this.onLihat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusCard),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris atas: Judul template dan badge tingkat formalitas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    template.judul,
                    style: AppTheme.judulKartu,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                // Badge tingkat formalitas (Formal / Santai)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusChip),
                  ),
                  child: Text(
                    template.tingkatFormal,
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Cuplikan isi teks template
            Text(
              template.isi,
              style: AppTheme.isi.copyWith(
                color: AppTheme.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            // Tombol aksi "Lihat"
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onLihat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: AppTheme.textPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusButton),
                  ),
                ),
                child: const Text('Lihat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
