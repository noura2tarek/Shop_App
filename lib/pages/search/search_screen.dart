import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/search/search_cubit/search_cubit.dart';
import 'package:shop_app/pages/search/search_cubit/search_states.dart';
import '../../shared/components/reusable_components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Container(
                // decoration: BoxDecoration(
                //   color: Colors.grey[200],
                //   borderRadius: BorderRadiusDirectional.circular(7.0),
                // ),
                width: 300.0,
                height: 45.0,
                child: defaultFormField(
                    type: TextInputType.text,
                    hint: '  Search',
                    controller: searchController,
                    preficon: Icons.search,
                    hintColor: Colors.grey[700],
                    prefixColor: Colors.grey[700],
                    prefixIconSize: 25.0,
                    inputBorder: InputBorder.none,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    // validator: (String? value) {
                    //   if (value!.isEmpty) {
                    //     return ('search data must not be null');
                    //   }
                    //   return null;
                    // },
                    onChange: (String? value) {
                      cubit.search(text: value!);
                    }),
              ),
            ),
            body: Column(
              children: [
                if (state is SearchLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is SearchSuccessState,
                    builder: (context) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildProductList(
                            cubit.model.data.data[index], context,
                            isSearch: true),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.model.data.data.length,
                      );
                    },
                    fallback: (context) => Container(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
