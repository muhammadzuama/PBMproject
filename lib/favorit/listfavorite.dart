class Favorit {
  String? title;
  String? penulis;
  String? urlImage;
  String? conten;

  Favorit(this.title, this.penulis, this.conten, this.urlImage);

  // ignore: non_constant_identifier_names
  static List<Favorit> DataFavorit = [
    Favorit(
        "Kopi: Sejarah, Proses Produksi,\$dan Ragam Jenisnya",
        "Alvito",
        "19 Mei 2023",
        "https://awsimages.detik.net.id/community/media/visual/2022/01/02/manfaat-kopi_169.jpeg?w=711"),
    Favorit(
        "Kopi di Dunia: Mengenal Budaya  Minum Kopi di Berbagai Negara",
        "Alvito",
        "hari ini Aksi yang dijalankan adalah menavigasi ke halaman detail artikel lagi, sehingga membuat penumpukan halaman (nested navigation) yang mungkin tidak diinginkan. Perlu diingat bahwa Anda mungkin perlu menyesuaikan logika navigasi sesuai kebutuhan aplikasi Anda.",
        "https://static.republika.co.id/uploads/images/inpicture_slide/peta-dunia-dengan-kopi-_160425095648-956.jpg?w=711"),
  ];
}
