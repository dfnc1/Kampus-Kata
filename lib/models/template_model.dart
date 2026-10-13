/// Mewakili satu kategori (kartu di grid Beranda).
class KategoriModel {
  final int id;
  final String nama;
  final String ikon; // nama ikon dalam bentuk teks, dipetakan ke Icons nanti

  KategoriModel({
    required this.id,
    required this.nama,
    required this.ikon,
  });

  // factory: membuat objek dari Map hasil jsonDecode
  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: json['id'],
      nama: json['nama'],
      ikon: json['ikon'],
    );
  }
}

/// Mewakili satu template pesan.
class TemplateModel {
  final int id;
  final String judul;
  final String kategori;
  final String tingkatFormal;
  final String isi;
  final String tips;
  final String kapanDipakai;
  final String janganDilakukan;

  TemplateModel({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.tingkatFormal,
    required this.isi,
    required this.tips,
    required this.kapanDipakai,
    required this.janganDilakukan,
  });

  // Nama key di kiri (json['...']) harus sama persis dengan di file JSON.
  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      judul: json['judul'],
      kategori: json['kategori'],
      tingkatFormal: json['tingkat_formal'],
      isi: json['isi'],
      tips: json['tips'],
      kapanDipakai: json['kapan_dipakai'],
      janganDilakukan: json['jangan_dilakukan'],
    );
  }
}