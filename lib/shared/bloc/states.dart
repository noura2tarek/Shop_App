import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}
class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);

}
class ShopChangeFavoritesColorState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}


class ShopLoadingGetUserDataState extends ShopStates {}
class ShopSuccessGetUserDataState extends ShopStates {}
class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopSuccessUpdateUserDataState extends ShopStates {
  LoginModel? model;
  ShopSuccessUpdateUserDataState(this.model);
}
class ShopErrorUpdateUserDataState extends ShopStates {}

class ShopLogoutSuccessState extends ShopStates {}
class ShopLogoutErrorState extends ShopStates {}

class ShopChangePhotoSuccessState extends ShopStates {}
class ShopChangePhotoErrorState extends ShopStates {}

class InternetConnectedSuccessState extends ShopStates {}
class InternetConnectedErrorState extends ShopStates {}
