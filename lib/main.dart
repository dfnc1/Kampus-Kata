import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KampusKataApp());
}

/// Widget root aplikasi KampusKata.
class KampusKataApp extends StatelessWidget {
  const KampusKataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KampusKata',
      debugShowCheckedModeBanner: false,
      // Menggunakan tema kustom sesuai panduan desain di docs/CONTEXT.md
      theme: AppTheme.lightTheme,
      // Halaman awal aplikasi: Beranda
      home: const HomeScreen(),
    );
  }
}
