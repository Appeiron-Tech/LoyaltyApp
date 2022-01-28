class ProductModel {
  int id = -1;
  String name = "";
  String image = "";
  String description = "";

  ProductModel({required this.id, required this.name, required this.image, required this.description});

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }
}
