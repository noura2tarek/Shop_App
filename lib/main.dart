import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Styles/themes.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/pages/login/login_screen.dart';
import 'package:shop_app/pages/on_boarding_screen.dart';
import 'package:shop_app/shared/controller/bloc/cubit.dart';
import 'package:shop_app/shared/controller/bloc/states.dart';
import 'package:shop_app/shared/controller/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure that all methods finished

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoard = CacheHelper.getData(key: 'onBoarding') as bool?;
  token = CacheHelper.getData(key: 'token') as String?;
  bool check = CacheHelper.checkData(key: 'currentIndex');
  if (check) {
    currentInndex = CacheHelper.getData(key: 'currentIndex') as int;
  }

  //print("token is $token");
  Widget widget;

  if (onBoard != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..checkInternet(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {
          if (state is InternetConnectedErrorState) {
            ShopCubit.get(context).checkInternet();
          }
        },
        builder: (BuildContext context, ShopStates state) {
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            //theme parameter executed when the theme mode is light
            //dark theme will executed when the theme mode is dark
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
