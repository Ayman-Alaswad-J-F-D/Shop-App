class ChangeFavortiesModel {
  bool? status;
  String? message;
  ChangeFavortiesDataModel? data;
  ChangeFavortiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? ChangeFavortiesDataModel.fromJson(json['data'])
        : null;
    // data = ChangeFavortiesDataModel.fromJson(json['data']);
  }
}

class ChangeFavortiesDataModel {
  int? id;
  ProductModel? products;
  ChangeFavortiesDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    products = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
