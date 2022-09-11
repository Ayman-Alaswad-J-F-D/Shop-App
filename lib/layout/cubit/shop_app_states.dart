import 'package:experiences_app/models/shop/change_favorites_model.dart';
import 'package:experiences_app/models/shop/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeButtonNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoitesState extends ShopStates {
  ShopSuccessChangeFavoitesState(ChangeFavortiesModel? model);
}

class ShopErrorChangeFavoitesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel? loginModel;
  ShopSuccessUserDataState(
    this.loginModel,
  );
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel? updateModel;
  ShopSuccessUpdateUserState(
    this.updateModel,
  );
}

class ShopErrorUpdateUserState extends ShopStates {}

class ShopEnableButtonUpdate extends ShopStates {
  final bool? enableButtonUpdate;
  ShopEnableButtonUpdate(
    this.enableButtonUpdate,
  );
}

class ShopChangeTextButtonClose extends ShopStates {
  final String? changeText;
  ShopChangeTextButtonClose(
    this.changeText,
  );
}
