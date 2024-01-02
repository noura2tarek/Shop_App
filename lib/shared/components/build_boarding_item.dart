
import 'package:flutter/material.dart';
import '../../models/boarding_model.dart';

Widget buildBoardingItem({required BoardingModel model}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image))),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontFamily: 'Montserrat-SemiBold',
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat-SemiBold',
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
    ],
  );
}