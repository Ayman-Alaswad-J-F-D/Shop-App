// ignore_for_file: avoid_print

import 'package:experiences_app/models/shop/search_model.dart';
import 'package:experiences_app/modules/Search/search_cubit/search_states.dart';
import 'package:experiences_app/shared/components/constants.dart';
import 'package:experiences_app/shared/network/end_points.dart';
import 'package:experiences_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH, data: {
      'text': text,
      token: token,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      print('Search status is');
      print(model?.status);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
