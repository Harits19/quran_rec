import 'package:xml/xml.dart';

class QuranModel {
  final List<SuraModel> suras;

  QuranModel({required this.suras});

  factory QuranModel.fromXML(XmlDocument document) {
    final quran = document.findAllElements("quran").first.childElements;
    return QuranModel(
      suras: quran.map((sura) => SuraModel.fromXML(sura)).toList(),
    );
  }
}

class SuraModel {
  final String index, name;
  final List<AyaModel> ayas;

  SuraModel({required this.ayas, required this.index, required this.name});
  factory SuraModel.fromXML(XmlElement element) {
    return SuraModel(
      name: element.getAttribute("name") ?? '-',
      index: element.getAttribute("index") ?? '-',
      ayas: element.childElements.map((aya) => AyaModel.fromXML(aya)).toList(),
    );
  }
}

class AyaModel {
  final String index;
  final String text;
  final String? bismillah;

  AyaModel({required this.index, required this.text, required this.bismillah});

  factory AyaModel.fromXML(XmlElement aya) {
    final index = aya.getAttribute("index") ?? '-';
    final text = aya.getAttribute("text") ?? '-';
    final bismillah = aya.getAttribute("bismillah") ?? '-';

    return AyaModel(index: index, text: text, bismillah: bismillah);
  }
}
