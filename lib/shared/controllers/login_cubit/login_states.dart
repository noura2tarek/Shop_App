import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  late LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
  late final String error;
  ShopLoginErrorState(this.error);
}
class ShoppChangePasswordVisibilityState extends ShopLoginStates{}