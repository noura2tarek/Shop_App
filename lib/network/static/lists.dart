
import 'package:flutter/material.dart';

import '../../models/boarding_model.dart';
import '../../pages/categories_screen.dart';
import '../../pages/favourites_screen.dart';
import '../../pages/home_screen.dart';
import '../../pages/settings_screen.dart';

List<BoardingModel> boardingList = [
  BoardingModel(
    image: 'assets/images/on_board1.png',
    title: 'SHOP ONLINE',
    body: 'Shop Now!',
  ),
  BoardingModel(
    image: 'assets/images/on_board2.png',
    title: 'TRACK YOUR ORDER',
    body: 'Order become easy!',
  ),
  BoardingModel(
    image: 'assets/images/on_board3.png',
    title: 'GET YOUR ORDER',
    body: 'Let\'s start! ',
  ),
];

// list of bottom navigation pages
List<Widget> bottomScreens = [
  HomeScreen(),
  CategoriesScreen(),
  FavouritesScreen(),
  SettingsScreen(),
];