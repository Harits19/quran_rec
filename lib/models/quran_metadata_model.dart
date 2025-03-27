import 'package:xml/xml.dart';

class QuranMetadataModel {
  final List<PageModel> pages;

  QuranMetadataModel({required this.pages});

  factory QuranMetadataModel.fromXML(XmlDocument document) {
    final pages = document.findAllElements("pages").first.childElements;

    return QuranMetadataModel(
      pages: pages.map((page) => PageModel.fromXML(page)).toList(),
    );
  }
}

class PageModel {
  final String index, sura, aya;

  PageModel({required this.index, required this.sura, required this.aya});

  factory PageModel.fromXML(XmlElement page) {
    final attributes = page.getAttribute;
    final index = attributes("index") ?? '-';
    final sura = attributes("sura") ?? '-';
    final aya = attributes("aya") ?? '-';

    return PageModel(index: index, sura: sura, aya: aya);
  }
}
