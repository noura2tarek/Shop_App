import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/categories_model.dart';

Widget buildCatItem(DataModel model) {
  String name = StringUtils.capitalize(model.name);
  return Padding(
    padding: const EdgeInsets.all(17.0),
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: model.image,
          placeholder:  (context, url) => Container(color: Colors.grey[300]),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 80.0,
          width: 80.0,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}