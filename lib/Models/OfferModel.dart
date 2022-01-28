class CategoryModel {
  int id = -1;
  String title = "";
  String description = "";
  int createdAt = 0;
  int expirationDays = 0;
  String image = "";
  int productId = 0;


  CategoryModel({required this.id, required this.title, required this.image, required this.description});

  CategoryModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['name'];
    image = json['image'];
    description = json['description'];
  }
}
