// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponse {
  UserResponse({
    this.infected,
    this.tested,
    this.recovered,
    this.deceased,
    this.country,
    this.moreData,
    this.historyData,
    this.sourceUrl,
    this.lastUpdatedApify,
    this.lastUpdatedSource,
  });

  int? infected;
  dynamic tested;
  dynamic recovered;
  dynamic deceased;
  String? country;
  String? moreData;
  String? historyData;
  String? sourceUrl;
  DateTime? lastUpdatedApify;
  String? lastUpdatedSource;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    infected: json["infected"],
    tested: json["tested"],
    recovered: json["recovered"],
    deceased: json["deceased"],
    country: json["country"],
    moreData: json["moreData"],
    historyData: json["historyData"],
    sourceUrl: json["sourceUrl"],
    lastUpdatedApify: json["lastUpdatedApify"] == null ? null : DateTime.parse(json["lastUpdatedApify"]),
    lastUpdatedSource: json["lastUpdatedSource"],
  );

  Map<String, dynamic> toJson() => {
    "infected": infected,
    "tested": tested,
    "recovered": recovered,
    "deceased": deceased,
    "country": country,
    "moreData": moreData,
    "historyData": historyData,
    "sourceUrl": sourceUrl,
    "lastUpdatedApify": lastUpdatedApify?.toIso8601String(),
    "lastUpdatedSource": lastUpdatedSource,
  };
}

enum DeceasedEnum { NA }

final deceasedEnumValues = EnumValues({
  "NA": DeceasedEnum.NA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
