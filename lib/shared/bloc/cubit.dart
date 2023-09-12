import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/pages/categories_screen.dart';
import 'package:shop_app/pages/favourites_screen.dart';
import 'package:shop_app/pages/home_screen.dart';
import 'package:shop_app/pages/settings_screen.dart';
import 'package:shop_app/shared/bloc/states.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../network/local/cache_helper.dart';
import '../../pages/login/login_screen.dart';
import '../components/components.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) {
    return BlocProvider.of(context);
  }

  //int currentIndex = 0;
  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentInndex = index;
    emit(ChangeBottomNavState());
    CacheHelper.savaData(key: 'currentIndex', value: currentInndex);
  }

  //get home(products & banners) data
  HomeModel? homeModel;
  Map<int, bool> favourites =
      {}; // to save favourites products from home model using productId, inFavourites Var
  //home data not need token so, when token is null. the function complete normally. but in our case to change icon color we need token.
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      lang: 'en',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      });
      print("Status of home data is ${homeModel?.status}");
      print("favourites of home data is ${favourites.toString()}");
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorHomeDataState());
    });
  }

  //get categories data
  CategoriesModel? categoriesModel;

  //categories data not need token so, when token is null. the function complete normally.
  void getCategoriesData() {
    DioHelper.getData(
      url: Categories,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorCategoriesDataState());
    });
  }

  //method to add or delete favorites
  late ChangeFavoritesModel cFavModel;

  void changeFavorites({required int productId}) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesColorState());
    DioHelper.postData(
      url: CHANGE_Favorites,
      token: token,
      lang: 'en',
      data: {
        "product_id": productId,
      },
    ).then((value) {
      cFavModel = ChangeFavoritesModel.fromJson(value.data);
      if (!(cFavModel.status)) {
        favourites[productId] = !favourites[productId]!;
        print("the product with id ${productId} ${cFavModel.message}");
      } else {
        getFavorites();
        print("the product with id ${productId} ${cFavModel.message}");
        emit(ShopSuccessChangeFavoritesState(cFavModel));
      }
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorChangeFavoritesState());
    });
  }

  // Color changeFavIcon({required int id}) {
  //   Color color = Colors.blue;
  //   if (favouritesProductsId.contains(id)) {
  //     color = Colors.blue;
  //   } else {
  //     color = Colors.grey;
  //   }
  //   return color;
  // }


  //favorites data need token so, when token is null. the function doesn't complete normally.
  //Get favorites
  FavoritesModel? favoritesModel;
  List<int> favouritesProductsId = [];

  ///list of favourites products
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: GET_Favorites,
      token: token,
      lang: 'en',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesModel?.data.data.forEach((element) {
        favouritesProductsId.add(element.product.id);
      });
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorGetFavoritesState());
    });
  }

  //profile data need token so, when token is null. the function doesn't complete normally.
  //Get Profile data
  LoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: 'en',
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print('user name is ${userModel!.data?.name}');
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorGetUserDataState());
    });
  }

  //update profile data using put
  LoginModel? updateUserModel;

  void updateUserData({
    String? name,
    String? phone,
    String? email,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      lang: 'en',
      token: token,
    ).then((value) {
      updateUserModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(updateUserModel));
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopErrorUpdateUserDataState());
    });
  }

  //log out
  late LogoutModel logoutModel;

  void logOut({required BuildContext context}) {
    DioHelper.postData(
      url: LOGOUT,
      token: token,
      lang: 'ar',
      data: {},
    ).then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      print(logoutModel.message);
      if (logoutModel.status) {
        emit(ShopLogoutSuccessState());
        //currentIndex = 0;
        CacheHelper.removeData(key: 'token').then((value) {
          if (value) {
            myImage = null;
            navigateAndRemove(context: context, widget: LoginScreen());
          }
        });
      }
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopLogoutErrorState());
    });
  }

  final ImagePicker picker = ImagePicker();
  File? myImage;

  Future pickImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        myImage = File(value.path);
      }
      emit(ShopChangePhotoSuccessState());
    }).catchError((error) {
      print('Error is occurred =>>  ${error.toString()}');
      emit(ShopChangePhotoErrorState());
    });
  }
// Pick an image.
//final XFile? image = await picker.pickImage(source: ImageSource.gallery);
}
