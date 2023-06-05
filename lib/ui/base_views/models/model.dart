class FetchDataModel {
  FetchDataModel({
    this.info,
    this.data,
  });

  FetchDataModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemData.fromJson(v));
      });
    }
  }
  Info? info;
  List<ItemData>? data;
  FetchDataModel copyWith({
    Info? info,
    List<ItemData>? data,
  }) =>
      FetchDataModel(
        info: info ?? this.info,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemData {
  ItemData({
    this.id,
    this.films,
    this.sourceUrl,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.v,
  });

  ItemData.fromJson(dynamic json) {
    id = json['_id'];
    films = json['films'] != null ? json['films'].cast<String>() : [];
    sourceUrl = json['sourceUrl'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    url = json['url'];
    v = json['__v'];
  }
  num? id;
  List<String>? films;
  String? sourceUrl;
  String? name;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  String? url;
  num? v;
  ItemData copyWith({
    num? id,
    List<String>? films,
    String? sourceUrl,
    String? name,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
    String? url,
    num? v,
  }) =>
      ItemData(
        id: id ?? this.id,
        films: films ?? this.films,
        sourceUrl: sourceUrl ?? this.sourceUrl,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        url: url ?? this.url,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['films'] = films;
    map['sourceUrl'] = sourceUrl;
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['url'] = url;
    map['__v'] = v;
    return map;
  }
}

class Info {
  Info({
    this.count,
    this.totalPages,
    this.previousPage,
    this.nextPage,
  });

  Info.fromJson(dynamic json) {
    count = json['count'];
    totalPages = json['totalPages'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
  }
  num? count;
  num? totalPages;
  String? previousPage;
  String? nextPage;
  Info copyWith({
    num? count,
    num? totalPages,
    String? previousPage,
    String? nextPage,
  }) =>
      Info(
        count: count ?? this.count,
        totalPages: totalPages ?? this.totalPages,
        previousPage: previousPage ?? this.previousPage,
        nextPage: nextPage ?? this.nextPage,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['totalPages'] = totalPages;
    map['previousPage'] = previousPage;
    map['nextPage'] = nextPage;
    return map;
  }
}
