// To receive response data after register and deal with it
// we can appear an error message in the UI screen so the user know what the error, the email he entered or what.
class RegisterModel {
  late bool status;
  String? message;
  RegisterUserData? data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterUserData.fromJson(json['data']) : null;
  }
}

class RegisterUserData {

  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  RegisterUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
