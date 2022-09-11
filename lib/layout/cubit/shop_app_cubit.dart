// ignore_for_file: avoid_print

import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/models/shop/categories_model.dart';
import 'package:experiences_app/models/shop/change_favorites_model.dart';
import 'package:experiences_app/models/shop/favorites_model.dart';
import 'package:experiences_app/models/shop/home_model.dart';
import 'package:experiences_app/models/shop/login_model.dart';
import 'package:experiences_app/modules/Cateogries/cateogries_screen.dart';
import 'package:experiences_app/modules/Favorites/favorites_screen.dart';
import 'package:experiences_app/modules/Prodacts/prodacts_screen.dart';
import 'package:experiences_app/modules/Settings/settings_screen.dart';
import 'package:experiences_app/shared/components/constants.dart';
import 'package:experiences_app/shared/network/end_points.dart';
import 'package:experiences_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  // bool? enableUpdate = true;
  void enableUpdateButton(bool? enableUpdateButton) {
    if (enableUpdateButton!) {
      enableUpdateButton = !enableUpdateButton;

      emit(ShopEnableButtonUpdate(enableUpdateButton));
    } else {
      enableUpdateButton = !enableUpdateButton;

      emit(ShopEnableButtonUpdate(enableUpdateButton));
    }
  }

  void changeTextButton(String? changeText) {
    changeText = 'Please Click Edit';
    emit(ShopChangeTextButtonClose(changeText));
  }

//////////////////////////

  int currentIndex = 0;

  List<Widget> bottomScreens = const [
    ProdactsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<String> titels = [
    'Salla',
    'Categories',
    'Favorites',
    'Profile',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeButtonNavState());
  }

/////////////////////////

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print('status is Home Data');
      print(homeModel?.status);
      // ignore: avoid_function_literals_in_foreach_calls
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });

      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

////////////////////////

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('status is Categories');
      print(categoriesModel?.status);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

////////////////////////

  Map<int, bool> favorites = {};
  ChangeFavortiesModel? changeFavoritesModel;
  void changeFavoritess(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavortiesModel.fromJson(value.data);
      print(
          '////// status Favorites is ${changeFavoritesModel!.status} //////');
      print(value.data);
      print(changeFavoritesModel?.message);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoitesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      print(error.toString());
      emit(ShopErrorChangeFavoitesState());
    });
  }

////////////////////////

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data);
      print('status is Favorites');
      print(favoritesModel?.status);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

////////////////////////

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(value.data);
      print('status is User Data');
      print(userModel?.status);
      print(userModel?.data!.name);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

////////////////////////

  void updateUserData({
    required name,
    required email,
    required phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(value.data);
      print('status is Update User Data');
      print(userModel?.status);
      print(userModel?.data!.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
