import 'package:food_app/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  //String? description; //// we donot want this in cart_model
  int? price;
  //int? stars;
  String? img;
  //String? location;
 // String? createdAt;
  //String? updatedAt;
  //int? typeId;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;



  CartModel(
      {this.id,
        this.name,
        //this.description,
        this.price,
        //this.stars,
        this.img,
        this.quantity,
        this.isExist,
        this.time,
        this.product,
       // this.location,
        //this.createdAt,
        //this.updatedAt,
        //this.typeId
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //description = json['description'];
    price = json['price'];
    //stars = json['stars'];
    img = json['img'];
    quantity=json['quantity'];
    isExist=json['isExist'];
    time=json['time'];
    product=ProductModel.fromJson(json['product']);
   // location = json['location'];
    //createdAt = json['created_at'];
    //updatedAt = json['updated_at'];
    //typeId = json['type_id'];
  }

  // methods to convert object into json
  Map<String,dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img": this.img,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "time": this.time,
      "product": this.product!.toJson(),
    };
  }

}
