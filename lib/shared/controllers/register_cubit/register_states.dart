

import '../../../models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  late RegisterModel registerModel;
  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegChangePasswordVisibilityState extends ShopRegisterStates{}