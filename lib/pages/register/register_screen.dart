import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/register/register_cubit/register_cubit.dart';
import 'package:shop_app/pages/register/register_cubit/register_states.dart';

import '../../Styles/colors.dart';
import '../../layout/home_layout.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/reusable_components.dart';
import '../../shared/components/constants.dart';
import '../../shared/controller/bloc/cubit.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              print(state.registerModel.message);
              CacheHelper.savaData(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = state.registerModel.data!.token;
                ShopCubit.get(context).getFavorites();
                ShopCubit.get(context).getUserData();
                ShopCubit.get(context).getHomeData();
                navigateAndRemove(context: context, widget: HomeLayout());

              });
            } else {
              showToast(
                message: state.registerModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        /////*******  Form fields ******////////
                        defaultFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'Name',
                          inputBorder: const OutlineInputBorder(),
                          preficon: Icons.person_outline,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email Address',
                          inputBorder: const OutlineInputBorder(),
                          preficon: Icons.email_outlined,
                          onSubmit: (value) {
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: 'Password',
                          inputBorder: const OutlineInputBorder(),
                          preficon: Icons.lock_outline,
                          isObsecure: ShopRegisterCubit.get(context).isPassword,
                          sufficon: ShopRegisterCubit.get(context).icon,
                          suffixPreesed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "password can't be blank";
                            } else if(value.length < 8 ){
                              return 'password is too short';
                            } else {
                              return null ;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          inputBorder: const OutlineInputBorder(),
                          preficon: Icons.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            } else {
                              return null;
                            }
                          },
                        ),
                        /////******* end of form fields ******////////
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return defaultButton(
                              text: 'Register',
                              backgroundColor: defaultColor,
                              isUpperCase: true,
                              function: () {
                                if (formKey.currentState!.validate()) {

                                  ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            );
                          },
                          fallback: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateAndRemove(
                                    context: context, widget: LoginScreen());
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
