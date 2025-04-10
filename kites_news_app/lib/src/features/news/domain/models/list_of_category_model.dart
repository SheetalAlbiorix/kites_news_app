class ListOfCategoryResponse {
  final int? timestamp;
  final List<Category>? categories;

  ListOfCategoryResponse({
    this.timestamp,
    this.categories,
  });

  factory ListOfCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ListOfCategoryResponse(
        timestamp: json["timestamp"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  final String? name;
  final String? file;

  Category({
    this.name,
    this.file,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "file": file,
      };
}
