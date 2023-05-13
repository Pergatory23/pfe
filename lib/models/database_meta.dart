import 'dart:convert';

DatabaseMeta decodeMetaFromJson(String str) => DatabaseMeta.fromJson(json.decode(str));

String welcomeToJson(DatabaseMeta data) => json.encode(data.toJson());

class DatabaseMeta {
    final List<Cube>? cubes;

    DatabaseMeta({
        this.cubes
    });

    factory DatabaseMeta.fromJson(Map<String, dynamic> json) => DatabaseMeta(
        cubes: json["cubes"] == null ? [] : List<Cube>.from(json["cubes"]!.map((x) => Cube.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cubes": cubes == null ? [] : List<dynamic>.from(cubes!.map((x) => x.toJson())),
    };
}

class Cube {
    final bool? public;
    final String? name;
    final String? type;
    final String? title;
    final List<Measure>? measures;
    final List<Dimension>? dimensions;
    final List<dynamic>? segments;

    Cube({
        this.public,
        this.name,
        this.type,
        this.title,
        this.measures,
        this.dimensions,
        this.segments,
    });

    factory Cube.fromJson(Map<String, dynamic> json) => Cube(
        public: json["public"],
        name: json["name"],
        type: json["type"],
        title: json["title"],
        measures: json["measures"] == null ? [] : List<Measure>.from(json["measures"]!.map((x) => Measure.fromJson(x))),
        dimensions: json["dimensions"] == null ? [] : List<Dimension>.from(json["dimensions"]!.map((x) => Dimension.fromJson(x))),
        segments: json["segments"] == null ? [] : List<dynamic>.from(json["segments"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "public": public,
        "name": name,
        "type": type,
        "title": title,
        "measures": measures == null ? [] : List<dynamic>.from(measures!.map((x) => x.toJson())),
        "dimensions": dimensions == null ? [] : List<dynamic>.from(dimensions!.map((x) => x.toJson())),
        "segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x)),
    };
}

class Dimension {
    final String? name;
    final String? title;
    final Type? type;
    final String? shortTitle;
    final bool? suggestFilterValues;
    final bool? isVisible;

    Dimension({
        this.name,
        this.title,
        this.type,
        this.shortTitle,
        this.suggestFilterValues,
        this.isVisible,
    });

    factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
        name: json["name"],
        title: json["title"],
        type: typeValues.map[json["type"]]!,
        shortTitle: json["shortTitle"],
        suggestFilterValues: json["suggestFilterValues"],
        isVisible: json["isVisible"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "type": typeValues.reverse[type],
        "shortTitle": shortTitle,
        "suggestFilterValues": suggestFilterValues,
        "isVisible": isVisible,
    };
}

enum Type { string, time }

final typeValues = EnumValues({
    "string": Type.string,
    "time": Type.time
});

class Measure {
    final String? name;
    final String? title;
    final String? shortTitle;
    final bool? cumulativeTotal;
    final bool? cumulative;
    final String? type;
    final String? aggType;
    final List<dynamic>? drillMembers;
    final DrillMembersGrouped? drillMembersGrouped;
    final bool? isVisible;

    Measure({
        this.name,
        this.title,
        this.shortTitle,
        this.cumulativeTotal,
        this.cumulative,
        this.type,
        this.aggType,
        this.drillMembers,
        this.drillMembersGrouped,
        this.isVisible,
    });

    factory Measure.fromJson(Map<String, dynamic> json) => Measure(
        name: json["name"],
        title: json["title"],
        shortTitle: json["shortTitle"],
        cumulativeTotal: json["cumulativeTotal"],
        cumulative: json["cumulative"],
        type: json["type"],
        aggType: json["aggType"],
        drillMembers: json["drillMembers"] == null ? [] : List<dynamic>.from(json["drillMembers"]!.map((x) => x)),
        drillMembersGrouped: json["drillMembersGrouped"] == null ? null : DrillMembersGrouped.fromJson(json["drillMembersGrouped"]),
        isVisible: json["isVisible"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "shortTitle": shortTitle,
        "cumulativeTotal": cumulativeTotal,
        "cumulative": cumulative,
        "type": type,
        "aggType": aggType,
        "drillMembers": drillMembers == null ? [] : List<dynamic>.from(drillMembers!.map((x) => x)),
        "drillMembersGrouped": drillMembersGrouped?.toJson(),
        "isVisible": isVisible,
    };
}

class DrillMembersGrouped {
    final List<dynamic>? measures;
    final List<dynamic>? dimensions;

    DrillMembersGrouped({
        this.measures,
        this.dimensions,
    });

    factory DrillMembersGrouped.fromJson(Map<String, dynamic> json) => DrillMembersGrouped(
        measures: json["measures"] == null ? [] : List<dynamic>.from(json["measures"]!.map((x) => x)),
        dimensions: json["dimensions"] == null ? [] : List<dynamic>.from(json["dimensions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "measures": measures == null ? [] : List<dynamic>.from(measures!.map((x) => x)),
        "dimensions": dimensions == null ? [] : List<dynamic>.from(dimensions!.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
