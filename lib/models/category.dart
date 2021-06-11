class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

final List<String> rawCat = [
  "general",
  "business",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology"
];

final List<Category> categoryList =
    rawCat.map<Category>((e) => Category.fromJson({'name': e})).toList();
