// ignore_for_file: avoid_print

import 'package:experiences_app/models/shop/login_model.dart';
// import 'package:experiences_app/modules/Login/login_cubit/login_states.dart';
import 'package:experiences_app/modules/Register/register_cubit/register_states.dart';
import 'package:experiences_app/shared/network/end_points.dart';
import 'package:experiences_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  // to be more esily when use this cubit
  static RegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        registerModel = ShopLoginModel.fromJson(value.data);
        print(registerModel?.status);
        print(registerModel?.message);
        print(registerModel?.data?.token);

        emit(RegisterSuccessState(registerModel!));
      },
    ).catchError((error) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisisbilaty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  // final width = MediaQuery.of(context).size.width;
}
