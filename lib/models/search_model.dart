//To receive search data from api
class SearchModel {
  bool? status;
  String? message;
  late SearchSDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchSDataModel.fromJson(json['data']);
  }
}

class SearchSDataModel {
  int? currentPage;
  List<SDataModel> data = <SDataModel>[];
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

  SearchSDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(SDataModel.fromJson(element));
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

class SDataModel {
  int? id;
  dynamic price;
  late String image;
  late String name;
  List<String> images = [];
  String? description;
  late bool inFavorites;
  late bool inCart;

  SDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];

    json['images'].forEach((element) {
      images.add(element);
    });

    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
