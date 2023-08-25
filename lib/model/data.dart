import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    Value valueOrDefault;
    Value value;
    bool isFailed;
    bool isSuccess;
    List<Reason> reasons;
    List<dynamic> errors;
    List<Reason> successes;

    Users({
        required this.valueOrDefault,
        required this.value,
        required this.isFailed,
        required this.isSuccess,
        required this.reasons,
        required this.errors,
        required this.successes,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        valueOrDefault: Value.fromJson(json["valueOrDefault"]),
        value: Value.fromJson(json["value"]),
        isFailed: json["isFailed"],
        isSuccess: json["isSuccess"],
        reasons: List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        successes: List<Reason>.from(json["successes"].map((x) => Reason.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "valueOrDefault": valueOrDefault.toJson(),
        "value": value.toJson(),
        "isFailed": isFailed,
        "isSuccess": isSuccess,
        "reasons": List<dynamic>.from(reasons.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "successes": List<dynamic>.from(successes.map((x) => x.toJson())),
    };
}

class Reason {
    String message;
    Metadata metadata;

    Reason({
        required this.message,
        required this.metadata,
    });

    factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        message: json["message"],
        metadata: Metadata.fromJson(json["metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "metadata": metadata.toJson(),
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Value {
    int total;
    List<Datum> data;

    Value({
        required this.total,
        required this.data,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String? guildGroupId;
    dynamic logo;
    String name;
    String brand;
    String? webSite;
    int storeCount;
    bool isFavorite;

    Datum({
        required this.id,
        this.guildGroupId,
        this.logo,
        required this.name,
        required this.brand,
        this.webSite,
        required this.storeCount,
        required this.isFavorite,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        guildGroupId: json["guildGroupId"],
        logo: json["logo"],
        name: json["name"],
        brand: json["brand"],
        webSite: json["webSite"],
        storeCount: json["storeCount"],
        isFavorite: json["isFavorite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "guildGroupId": guildGroupId,
        "logo": logo,
        "name": name,
        "brand": brand,
        "webSite": webSite,
        "storeCount": storeCount,
        "isFavorite": isFavorite,
    };
}
