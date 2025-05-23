import 'dart:convert';

enum Status {
  asd,
  sss;

  const Status();

  String toJson() {
    return name;
  }

  static Status fromJson(dynamic json) {
    final value = Status.values.firstWhere((item) => item.name == json);

    return value;
  }
}

main() {
  final encode = (json.encode(Status.asd));
  final decode = Status.fromJson(json.decode(encode));

  print("encode $encode, decode $decode");
}
