class QuranModel {
  final List<SuraModel> suras;

  QuranModel({required this.suras});
}

class SuraModel {
  final List<AyaModel> ayas;

  SuraModel({required this.ayas});
}

class AyaModel {
  final String index;
  final String text;
  final String? bismillah;

  AyaModel({required this.index, required this.text, required this.bismillah});
}
