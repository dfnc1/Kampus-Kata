import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Konfigurasi tema terpusat untuk aplikasi KampusKata sesuai dengan docs/CONTEXT.md.
/// Mahasiswa dapat mengakses warna, style font, dan ukuran radius langsung lewat kelas ini.
class AppTheme {
  // --- PALET WARNA ---
  // Navy: warna utama untuk AppBar, header, dan elemen dominan
  static const Color primaryColor = Color(0xFF1E3A5F);

  // Kuning: warna aksen untuk tombol aksi utama dan sorotan
  static const Color accentColor = Color(0xFFFFC93C);

  // Krem: warna latar belakang aplikasi
  static const Color backgroundColor = Color(0xFFFFF8E7);

  // Putih: warna permukaan kartu
  static const Color cardColor = Color(0xFFFFFFFF);

  // Teks utama (gelap)
  static const Color textPrimary = Color(0xFF1F2937);

  // Teks sekunder (abu-abu netral)
  static const Color textSecondary = Color(0xFF6B7280);

  // Status bahaya / hal yang jangan dilakukan (merah muda lembut untuk latar)
  static const Color dangerBackground = Color(0xFFFDECEC);

  // Teks bahaya / peringatan
  static const Color dangerText = Color(0xFFB91C1C);

  // --- UKURAN RADIUS & PADDING ---
  // Radius sudut untuk kartu dan tombol (16)
  static const double radiusCard = 16.0;
  static const double radiusButton = 16.0;

  // Radius sudut untuk chip dan search bar (24)
  static const double radiusChip = 24.0;
  static const double radiusSearchBar = 24.0;

  // Padding layar default (16) dan jarak antar kartu (12)
  static const double screenPadding = 16.0;
  static const double cardSpacing = 12.0;

  // --- GAYA TEKS (POPPINS) ---
  // Judul: 22 bold
  static TextStyle get judul => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      );

  // Heading: 16 semibold
  static TextStyle get heading => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  // Judul kartu: 14 semibold
  static TextStyle get judulKartu => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  // Isi teks / body: 14 regular
  static TextStyle get isi => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      );

  // Caption: 12 regular
  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondary,
      );

  // --- THEMEDATA LENGKAP ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardColor,
        error: dangerText,
        onPrimary: Colors.white,
        onSecondary: textPrimary,
        onSurface: textPrimary,
      ),

      // Konfigurasi AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Konfigurasi Card: flat tanpa bayangan berlebih, radius 16
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
        ),
        margin: EdgeInsets.zero,
      ),

      // Konfigurasi Tombol Utama: tombol kuning, teks gelap, radius 16, flat
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Konfigurasi Chip: radius 24
      chipTheme: ChipThemeData(
        backgroundColor: cardColor,
        selectedColor: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusChip),
          side: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
      ),

      // Konfigurasi TextField / Search Bar: radius 24, flat
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSearchBar),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSearchBar),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSearchBar),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: textSecondary,
        ),
      ),

      // Konfigurasi BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Hierarki gaya teks Poppins
      textTheme: TextTheme(
        titleLarge: judul,
        titleMedium: heading,
        titleSmall: judulKartu,
        bodyMedium: isi,
        bodySmall: caption,
      ),
    );
  }
}
