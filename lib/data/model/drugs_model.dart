import 'dart:convert';

class DrugList {
  DrugList({
    this.id,
    this.name,
    this.arabic,
    this.oldprice,
    this.price,
    this.activeConstituents,
    this.description,
    this.company,
    this.dosageForm,
    this.units,
    this.barcode,
  });

  int? id;
  String? name;
  String? arabic;
  String? oldprice;
  String? price;
  String? activeConstituents;
  String? description;
  String? company;
  String? dosageForm;
  int? units;
  String? barcode;

  factory DrugList.fromRawJson(String str) =>
      DrugList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrugList.fromJson(Map<String, dynamic> json) => DrugList(
        id: json["id"],
        name: json["name"],
        arabic: json["arabic"],
        oldprice: json["oldprice"] ?? "",
        price: json["price"] ?? "",
        activeConstituents: json["active"] ?? "",
        description: json["description"] ?? "",
        company: json["company"] ?? "",
        dosageForm: json["dosage_form"] ?? "",
        units: int.tryParse(json["units"].toString()) ?? 0, // Convert to int
        barcode: json["barcode"] ?? "0", // Provide a default value for String
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic": arabic,
        "oldprice": oldprice,
        "price": price,
        "active": activeConstituents,
        "description": description,
        "company": company,
        "dosage_form": dosageForm,
        "units": units,
        "barcode": barcode,
      };
}
