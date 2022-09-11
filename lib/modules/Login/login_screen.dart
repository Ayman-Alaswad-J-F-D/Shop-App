// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'package:experiences_app/layout/shop_layout.dart';
import 'package:experiences_app/modules/Login/login_cubit/login_cubit.dart';
import 'package:experiences_app/modules/Login/login_cubit/login_states.dart';
import 'package:experiences_app/modules/Register/register_screen.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:experiences_app/shared/components/constants.dart';
import 'package:experiences_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token!;
                  navigateAndFinish(context, ShopLayout());
                },
              );
              showToastLong(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              print(state.loginModel.message);
              showToastLong(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepPurple,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    ' Log In',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '   Login now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 12,
                              color: Colors.white,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 26,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        child: myTextFormField(
                                          openEnabled: true,
                                          filledNeed: true,
                                          fillColor: Colors.grey.shade100,
                                          textEditingController:
                                              emailController,
                                          typeInput: TextInputType.emailAddress,
                                          label: 'E-mail',
                                          colorLableText:
                                              Colors.deepOrange.shade500,
                                          prefixIcon:
                                              const Icon(Icons.email_outlined),
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'please enter your email address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 80,
                                        child: myTextFormField(
                                          openEnabled: true,
                                          filledNeed: true,
                                          fillColor: Colors.grey.shade100,
                                          textEditingController:
                                              passwordController,
                                          typeInput:
                                              TextInputType.visiblePassword,
                                          isPassword: cubit.isPassword,
                                          onSubmit: (String value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              ShopLoginCubit.get(context)
                                                  .userLogin(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                          suffixIcon: cubit.suffix,
                                          suffixPressed: () =>
                                              cubit.changePasswordVisisbilaty(),
                                          label: 'Password',
                                          colorLableText:
                                              Colors.deepOrange.shade500,
                                          prefixIcon: const Icon(
                                              Icons.lock_outline_rounded),
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'please is too short';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => myButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                childOrText: const Text(
                                  'Login',
                                  style: TextStyle(
                                    // height: 2,
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Pacifico',
                                    letterSpacing: 1,
                                  ),
                                ),
                                radius: 20,
                              ),
                              fallback: (context) => ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  maximumSize: const Size.fromHeight(37),
                                  elevation: 7,
                                  textStyle: const TextStyle(fontSize: 17),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/images/welcome-loading-animation.json',
                                      fit: BoxFit.cover,
                                    ),
                                    // const SizedBox(width: 10),
                                    const Text(
                                      'Please Wait ...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Pacifico',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'Don\'t have an accuont ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                myTextButton(
                                  // uniqueKey: const Key('btn1'),
                                  finction: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'register',
                                  colortext: Colors.deepOrange.shade500,
                                  lineInText: TextDecoration.underline,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.black,
                                  height: 0.5,
                                  width: 115,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text('or'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  color: Colors.black,
                                  height: 0.5,
                                  width: 115,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FloatingActionButton(
                                  backgroundColor: Colors.deepPurple,
                                  heroTag: 'facebook',
                                  mini: true,
                                  onPressed: () {
                                    showToastShort(
                                        text: 'SOON',
                                        state: ToastStates.WARNING);
                                  },
                                  child: const Icon(
                                    Icons.facebook_rounded,
                                    size: 35,
                                  ),
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.deepPurple,
                                  heroTag: 'google',
                                  mini: true,
                                  onPressed: () {
                                    showToastShort(
                                        text: 'SOON',
                                        state: ToastStates.WARNING);
                                  },
                                  child: const Icon(
                                    Icons.g_mobiledata_outlined,
                                    size: 40,
                                  ),
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.deepPurple,
                                  heroTag: 'gust',
                                  mini: true,
                                  onPressed: () {
                                    showToastShort(
                                        text: 'SOON',
                                        state: ToastStates.WARNING);
                                  },
                                  child: const Icon(
                                    Icons.group_add_outlined,
                                    size: 23,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
