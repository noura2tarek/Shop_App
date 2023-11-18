import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/bloc/cubit.dart';
import 'package:shop_app/shared/bloc/states.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var  cubit = ShopCubit.get(context);
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).categoriesModel != null && ShopCubit.get(context).homeModel != null,
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder:(context, index) =>  buildCatItem(cubit.categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.categoriesModel!.data.data.length,
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

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
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
  }
}
