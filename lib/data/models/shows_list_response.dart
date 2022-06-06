import 'dart:convert';

class ShowsListResponse {
  ShowsListResponse({
    this.shows,
    this.meta,
  });

  final List<Show>? shows;
  final Meta? meta;

  factory ShowsListResponse.fromRawJson(String str) =>
      ShowsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowsListResponse.fromJson(Map<String, dynamic> json) =>
      ShowsListResponse(
        shows: List<Show>.from(json["shows"].map((x) => Show.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "shows": shows != null
            ? List<dynamic>.from(shows!.map((x) => x.toJson()))
            : null,
        "meta": meta!.toJson(),
      };
}

class Meta {
  Meta({
    this.pagination,
  });

  final Pagination? pagination;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
      };
}

class Pagination {
  Pagination({
    this.count,
    this.page,
    this.items,
    this.pages,
  });

  final int? count;
  final int? page;
  final int? items;
  final int? pages;

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        page: json["page"],
        items: json["items"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "items": items,
        "pages": pages,
      };
}

class Show {
  Show({
    this.id,
    this.averageRating,
    this.description,
    this.imageUrl,
    this.noOfReviews,
    this.title,
  });

  final String? id;
  final int? averageRating;
  final String? description;
  final String? imageUrl;
  final int? noOfReviews;
  final String? title;

  factory Show.fromRawJson(String str) => Show.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        averageRating: json["average_rating"],
        description: json["description"],
        imageUrl: json["image_url"],
        noOfReviews: json["no_of_reviews"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "average_rating": averageRating,
        "description": description,
        "image_url": imageUrl,
        "no_of_reviews": noOfReviews,
        "title": title,
      };
}
