// To parse this JSON data, do
//
//     final bldPark = bldParkFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BldPark {
  BldPark({
    required this.type,
    required this.crs,
    required this.features,
  });

  String type;
  Crs crs;
  List<Feature> features;

  factory BldPark.fromRawJson(String str) => BldPark.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BldPark.fromJson(Map<String, dynamic> json) => BldPark(
    type: json["type"],
    crs: Crs.fromJson(json["crs"]),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "crs": crs.toJson(),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class Crs {
  Crs({
    required this.type,
    required this.properties,
  });

  String type;
  CrsProperties properties;

  factory Crs.fromRawJson(String str) => Crs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
    type: json["type"],
    properties: CrsProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties.toJson(),
  };
}

class CrsProperties {
  CrsProperties({
    required this.href,
    required this.type,
  });

  String href;
  String type;

  factory CrsProperties.fromRawJson(String str) => CrsProperties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
    href: json["href"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "type": type,
  };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  FeatureType type;
  Geometry geometry;
  FeatureProperties properties;

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: featureTypeValues.map[json["type"]]!,
    geometry: Geometry.fromJson(json["geometry"]),
    properties: FeatureProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": featureTypeValues.reverse[type],
    "geometry": geometry.toJson(),
    "properties": properties.toJson(),
  };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  GeometryType type;
  List<dynamic> coordinates;

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: geometryTypeValues.map[json["type"]]!,
    coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": geometryTypeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

enum GeometryType { POLYGON, MULTI_POLYGON, POINT }

final geometryTypeValues = EnumValues({
  "MultiPolygon": GeometryType.MULTI_POLYGON,
  "Point": GeometryType.POINT,
  "Polygon": GeometryType.POLYGON
});

class FeatureProperties {
  FeatureProperties({
    required this.fc,
    required this.gisId,
    required this.versionId,
    required this.parkNo,
    required this.tempId,
    required this.parkAdi,
    required this.parkYapimTarihi,
    required this.toplamAlani,
    required this.sulamaTesisiVarmi,
    required this.aydinlatmaVarmi,
    required this.kaydeden,
    required this.kayitTarihi,
    required this.ilkKaydeden,
    required this.ilkKayitTarihi,
    required this.aktifMi,
  });

  int fc;
  int gisId;
  int versionId;
  int parkNo;
  int tempId;
  String parkAdi;
  DateTime parkYapimTarihi;
  double toplamAlani;
  Varmi sulamaTesisiVarmi;
  Varmi aydinlatmaVarmi;
  Kaydeden kaydeden;
  DateTime kayitTarihi;
  IlkKaydeden ilkKaydeden;
  DateTime ilkKayitTarihi;
  int aktifMi;

  factory FeatureProperties.fromRawJson(String str) => FeatureProperties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
    fc: json["FC"],
    gisId: json["GIS_ID"],
    versionId: json["VERSION_ID"],
    parkNo: json["PARK_NO"],
    tempId: json["TEMP_ID"],
    parkAdi: json["PARK_ADI"],
    parkYapimTarihi: DateTime.parse(json["PARK_YAPIM_TARIHI"]),
    toplamAlani: json["TOPLAM_ALANI"].toDouble(),
    sulamaTesisiVarmi: varmiValues.map[json["SULAMA_TESISI_VARMI"]]!,
    aydinlatmaVarmi: varmiValues.map[json["AYDINLATMA_VARMI"]]!,
    kaydeden: kaydedenValues.map[json["KAYDEDEN"]]!,
    kayitTarihi: DateTime.parse(json["KAYIT_TARIHI"]),
    ilkKaydeden: ilkKaydedenValues.map[json["ILK_KAYDEDEN"]]!,
    ilkKayitTarihi: DateTime.parse(json["ILK_KAYIT_TARIHI"]),
    aktifMi: json["AKTIF_MI"],
  );

  Map<String, dynamic> toJson() => {
    "FC": fc,
    "GIS_ID": gisId,
    "VERSION_ID": versionId,
    "PARK_NO": parkNo,
    "TEMP_ID": tempId,
    "PARK_ADI": parkAdi,
    "PARK_YAPIM_TARIHI": parkYapimTarihi.toIso8601String(),
    "TOPLAM_ALANI": toplamAlani,
    "SULAMA_TESISI_VARMI": varmiValues.reverse[sulamaTesisiVarmi],
    "AYDINLATMA_VARMI": varmiValues.reverse[aydinlatmaVarmi],
    "KAYDEDEN": kaydedenValues.reverse[kaydeden],
    "KAYIT_TARIHI": kayitTarihi.toIso8601String(),
    "ILK_KAYDEDEN": ilkKaydedenValues.reverse[ilkKaydeden],
    "ILK_KAYIT_TARIHI": ilkKayitTarihi.toIso8601String(),
    "AKTIF_MI": aktifMi,
  };
}

enum Varmi { EMPTY, H, E }

final varmiValues = EnumValues({
  "E": Varmi.E,
  "": Varmi.EMPTY,
  "H": Varmi.H
});

enum IlkKaydeden { TEROL, EMPTY, MAHMURE, FATH, MEHMET, CAGLAR, ZEYNEP, EMRE, PROJE, FAT_H }

final ilkKaydedenValues = EnumValues({
  "CAGLAR": IlkKaydeden.CAGLAR,
  "": IlkKaydeden.EMPTY,
  "EMRE": IlkKaydeden.EMRE,
  "FATİH": IlkKaydeden.FATH,
  "FAT?H": IlkKaydeden.FAT_H,
  "MAHMURE": IlkKaydeden.MAHMURE,
  "MEHMET": IlkKaydeden.MEHMET,
  "PROJE": IlkKaydeden.PROJE,
  "TEROL": IlkKaydeden.TEROL,
  "ZEYNEP": IlkKaydeden.ZEYNEP
});

enum Kaydeden { TEROL, EMPTY, MAHMURE, FATH, NURSEL, PROJE, ZPLANCI }

final kaydedenValues = EnumValues({
  "": Kaydeden.EMPTY,
  "FATİH": Kaydeden.FATH,
  "MAHMURE": Kaydeden.MAHMURE,
  "NURSEL": Kaydeden.NURSEL,
  "PROJE": Kaydeden.PROJE,
  "TEROL": Kaydeden.TEROL,
  "ZPLANCI": Kaydeden.ZPLANCI
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
  "Feature": FeatureType.FEATURE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
