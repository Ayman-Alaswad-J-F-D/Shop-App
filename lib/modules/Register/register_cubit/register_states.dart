import 'package:experiences_app/models/shop/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final ShopLoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}
