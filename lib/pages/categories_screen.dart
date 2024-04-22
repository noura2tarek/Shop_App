import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/reusable_components/reusable_components.dart';
import '../shared/components/build_category_item.dart';
import '../shared/controllers/shared_bloc/cubit.dart';
import '../shared/controllers/shared_bloc/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: ShopCubit.get(context).categoriesModel != null &&
              ShopCubit.get(context).homeModel != null,
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  buildCatItem(cubit.categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.categoriesModel!.data.data.length,
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
