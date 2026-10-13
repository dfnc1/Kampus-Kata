import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/template_model.dart';

/// Satu-satunya tempat yang tahu dari mana data berasal.
/// Nanti kalau pindah ke API, cukup ubah isi _loadJson() jadi http.get(...),
/// halaman-halaman tidak perlu diubah.
class DataService {
  // Langkah 1: baca file JSON dari assets sebagai teks, lalu ubah jadi Map.
  Future<Map<String, dynamic>> _loadJson() async {
    final String teks =
    await rootBundle.loadString('assets/data/templates.json');
    return jsonDecode(teks) as Map<String, dynamic>;
  }

  // Langkah 2: ambil list "kategori" dan ubah tiap item jadi KategoriModel.
  Future<List<KategoriModel>> getKategori() async {
    final data = await _loadJson();
    final List list = data['kategori'];
    return list.map((item) => KategoriModel.fromJson(item)).toList();
  }

  // Langkah 3: ambil list "templates" dan ubah tiap item jadi TemplateModel.
  Future<List<TemplateModel>> getTemplates() async {
    final data = await _loadJson();
    final List list = data['templates'];
    return list.map((item) => TemplateModel.fromJson(item)).toList();
  }

  // Dipakai di halaman Daftar: ambil template berdasarkan nama kategori.
  Future<List<TemplateModel>> getTemplatesByKategori(String kategori) async {
    final semua = await getTemplates();
    return semua.where((t) => t.kategori == kategori).toList();
  }
}