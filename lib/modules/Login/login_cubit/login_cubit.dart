// ignore_for_file: avoid_print

import 'package:experiences_app/models/shop/login_model.dart';
import 'package:experiences_app/modules/Login/login_cubit/login_states.dart';
import 'package:experiences_app/shared/network/end_points.dart';
import 'package:experiences_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  // to be more esily when use this cubit
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        print(loginModel?.status);
        print(loginModel?.message);
        print(loginModel?.data?.token);

        emit(ShopLoginSuccessState(loginModel!));
      },
    ).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisisbilaty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
