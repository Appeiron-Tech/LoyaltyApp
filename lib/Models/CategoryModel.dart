class CategoryModel {
  int id = -1;
  String name = "";
  String image = "";
  String description = "";

  CategoryModel({required this.id, required this.name, required this.image, required this.description});

  CategoryModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }
}
