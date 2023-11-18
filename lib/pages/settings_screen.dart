import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Styles/colors.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/bloc/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import '../shared/bloc/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserDataState) {
          if (state.model!.status) {
            ShopCubit.get(context).getUserData();
            showToast(
              message: state.model!.message!,
              state: ToastStates.SUCCESS,
            );
          } else {
            showToast(
              message: state.model!.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) {
            LoginModel? model = ShopCubit.get(context).userModel;
            nameController.text = model!.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              if (ShopCubit.get(context).myImage != null)
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                                  ),
                                  height: 90.0,
                                  width: 84.0,
                                  child: Image.file(
                                    filterQuality: FilterQuality.high,
                                    ShopCubit.get(context).myImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (ShopCubit.get(context).myImage == null)
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: model.data!.image!,
                                    placeholder: (context, url) => Container(color: Colors.grey[300]),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    filterQuality: FilterQuality.high,
                                    height: 90.0,
                                    width: 84.0,
                                    fit: BoxFit.cover,

                                  ),
                                ),
                              IconButton(
                                splashRadius: 28.0,
                                onPressed: () {
                                  ShopCubit.get(context).pickImage();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 24.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            model.data!.name!,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      if (state is ShopLoadingUpdateUserDataState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        type: TextInputType.text,
                        controller: nameController,
                        label: 'Name',
                        preficon: Icons.person,
                        inputBorder: OutlineInputBorder(),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: 'Email Address',
                        preficon: Icons.email,
                        inputBorder: OutlineInputBorder(),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        type: TextInputType.phone,
                        controller: phoneController,
                        label: 'Phone',
                        preficon: Icons.phone,
                        inputBorder: OutlineInputBorder(),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ' phone must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defaultButton(
                        backgroundColor: defaultColor,
                        text: 'logout',
                        function: () {
                          ShopCubit.get(context).logOut(context: context);
                        },
                      ),
                      const SizedBox(
                        height: 23.0,
                      ),
                      defaultButton(
                        backgroundColor: defaultColor,
                        text: 'update data',
                        function: () {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
