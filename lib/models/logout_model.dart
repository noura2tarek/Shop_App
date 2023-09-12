class LogoutModel{

  late bool status;
  String? message;
  UserLogoutData? data;

  LogoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserLogoutData.fromJson(json['data']) : null;
  }


}

class UserLogoutData {
  int? id;
  String? token;

  UserLogoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

}
