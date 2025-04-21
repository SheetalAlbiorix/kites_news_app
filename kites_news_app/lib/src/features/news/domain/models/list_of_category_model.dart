class ListOfCategoryResponse {
  final int? timestamp;
  final List<Category>? categories;

  ListOfCategoryResponse({this.timestamp, this.categories});

  factory ListOfCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ListOfCategoryResponse(
        timestamp: json["timestamp"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfCategoryResponse &&
          runtimeType == other.runtimeType &&
          timestamp == other.timestamp &&
          _listsEqual(other.categories ?? [], categories ?? []);

  bool _listsEqual(List<Category> list1, List<Category> list2) {
    if (list1.length != list2.length) return false;
    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => timestamp.hashCode ^ categories.hashCode;
}

class Category {
  final String? name;
  final String? file;

  Category({this.name, this.file});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json["name"], file: json["file"]);

  Map<String, dynamic> toJson() => {"name": name, "file": file};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          file == other.file;

  @override
  int get hashCode => name.hashCode ^ file.hashCode;
}
