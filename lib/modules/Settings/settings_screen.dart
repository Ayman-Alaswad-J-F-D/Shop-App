// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:conditional_builder/conditional_builder.dart';
import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:experiences_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  bool? enableButton = false;
  String? textButtonClosed = 'Closed';
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ShopCubit.get(context).getUserData();
    ShopCubit.get(context).getFavorites();
    ShopCubit.get(context).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {
          if (state is ShopEnableButtonUpdate)
            {
              enableButton = state.enableButtonUpdate,
              textButtonClosed = 'Closed',
            }
          else if (state is ShopChangeTextButtonClose)
            {
              textButtonClosed = state.changeText,
            }
          else if (state is ShopSuccessUpdateUserState)
            {
              enableButton = false,
              showToastLong(text: 'Update is DONE', state: ToastStates.SUCCESS)
            }
          else if (state is ShopErrorUserDataState)
            {
              showToastLong(
                  text: 'Something is wrong !', state: ToastStates.WARNING),
            }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          var model = ShopCubit.get(context).userModel;
          nameController.text = model?.data?.name ?? 'Empty ..';
          emailController.text = model?.data?.email ?? 'Empty ..';
          phoneController.text = model?.data?.phone ?? 'Empty ..';

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (contetx) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.8),
                    Colors.deepPurple.shade200.withOpacity(.1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 7.5),
                        SizedBox(
                          child: state is ShopLoadingUpdateUserState
                              ? const LinearProgressIndicator()
                              : null,
                          height: 2,
                        ),
                        const SizedBox(height: 9),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            color: Colors.deepPurple.shade300,
                          ),
                          width: 150,
                          height: 150,
                          child: Image.network(
                            cubit.userModel?.data?.image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return Center(
                                child: Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.grey.shade100,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          height: 90,
                          child: myTextFormField(
                            hintText: 'User Name',
                            openHelberText: enableButton,
                            openEnabled: enableButton,
                            textEditingController: nameController,
                            typeInput: TextInputType.name,
                            label: '',
                            colorLableText: Colors.deepPurple,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'name most not be empty';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.person),
                            filledNeed: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: myTextFormField(
                            hintText: 'E-mail Address',
                            openHelberText: enableButton,
                            openEnabled: enableButton,
                            textEditingController: emailController,
                            typeInput: TextInputType.emailAddress,
                            label: '',
                            colorLableText: Colors.deepPurple,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'name most not be empty';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.email_rounded),
                            filledNeed: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: myTextFormField(
                            hintText: 'Password',
                            openHelberText: enableButton,
                            openEnabled: enableButton,
                            textEditingController: phoneController,
                            typeInput: TextInputType.phone,
                            label: '',
                            colorLableText: Colors.deepPurple,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'name most not be empty';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                            ),
                            filledNeed: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                        myButton(
                          function: () => singOut(context),
                          childOrText: const Text(
                            'LogOut',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            myButton(
                              function: () {
                                cubit.enableUpdateButton(enableButton);
                              },
                              width: 150,
                              childOrText: Text(
                                enableButton! ? 'Close' : 'Edit',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            myButton(
                              function: () {
                                if (enableButton!) {
                                  if (formKey.currentState!.validate()) {
                                    cubit.updateUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                } else {
                                  cubit.changeTextButton(textButtonClosed);
                                }
                              },
                              width: 150,
                              backgound: enableButton!
                                  ? Colors.deepPurple
                                  : Colors.red.shade400.withOpacity(0.85),
                              childOrText: Text(
                                enableButton! ? 'UpDate' : textButtonClosed!,
                                style: TextStyle(
                                  color: enableButton!
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 30),
                        // if (true)
                        //   myButton(
                        //     function: () {},
                        //     width: 120,
                        //     childOrText: const Text(
                        //       'Reload',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (contetx) => Center(
              child: LottieBuilder.asset(
                'assets/images/welcome-loading-animation.json',
                height: 200,
                width: 200,
              ),
            ),
          );
        },
      ),
    );
  }
}
