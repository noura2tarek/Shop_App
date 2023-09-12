// To receive home data of products using api (home) in apis Collection

class HomeModel{
 bool? status;
 String? message;
 late HomeDataModel data;

 HomeModel.fromJson(Map<String , dynamic> json){
   status = json['status'];
   message =json['message'];
   //named constructor
   data = HomeDataModel.fromJson(json['data']);
 }
}
class HomeDataModel{
 List<BannerModel> banners = <BannerModel>[] ;
 List<ProductModel> products = <ProductModel>[];
 String? ad;
 //named constructor
 HomeDataModel.fromJson(Map<String , dynamic> json){
  json['banners'].forEach((element){
   banners.add(BannerModel.fromJson(element));
  });
  json['products'].forEach((element){
   products.add(ProductModel.fromJson(element));
  });

  ad= json['ad'];
 }
}
class BannerModel{
 int? id;
 String? image;
 dynamic category;
 dynamic product;

 BannerModel.fromJson(Map<String , dynamic> json){
   id =json['id'];
   image =json['image'];

 }
}
class ProductModel{
late int id;
late dynamic price;
late dynamic oldPrice;
late dynamic discount;
late String image;
late String name;
late bool inFavorites;
late bool inCart;
//named constructor
 ProductModel.fromJson(Map<String , dynamic> json){
  id = json['id'];
  price = json['price'];
  oldPrice = json['old_price'];
  discount = json['discount'];
  image = json['image'];
  name = json['name'];
  inFavorites = json['in_favorites'];
  inCart = json['in_cart'];

  }

 }

