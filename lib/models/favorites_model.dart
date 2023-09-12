class FavoritesModel {
  bool? status;
  String? message;
  late FavoritesDataModel data;


  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  FavoritesDataModel.fromJson(json['data']);
  }


}

class FavoritesDataModel {
  int? currentPage;
  List<DataModel> data =<DataModel> [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;



  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((element) {
        data.add( DataModel.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class DataModel {
  int? id;
 late FavProductModel product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavProductModel.fromJson(json['product']);
  }
}

class FavProductModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  late String image;
  late String name;
  String? description;

  FavProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
