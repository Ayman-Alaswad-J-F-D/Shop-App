// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/shop_layout.dart';
import 'package:experiences_app/shared/components/constants.dart';
import 'package:experiences_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experiences_app/appcubit/app_cubit.dart';
import 'package:experiences_app/appcubit/app_states.dart';
import 'package:experiences_app/modules/Login/login_screen.dart';
import 'package:experiences_app/shared/bloc_observer.dart';
import 'package:experiences_app/shared/network/local/cache_helper.dart';
import 'package:experiences_app/shared/network/remote/dio_helper.dart';
import 'modules/OnBoarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  Widget widget;

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      DioHelper.init();
      bool? isDark = CacheHelper.getBoolean(key: 'isDark');
      print("Is Dark => $isDark");

      bool onBoarding = CacheHelper.getData(key: 'onBoarding');
      print('onBoarding = $onBoarding');

      token = CacheHelper.getData(key: 'token');
      if (onBoarding != null) {
        if (token != null) {
          widget = ShopLayout();
          print('token is $token\n=> Your in Home Page');
        } else {
          widget = ShopLoginScreen();
          print('=> Your in Login Screen');
        }
      } else {
        widget = OnBoardingScreen();
        print('First Start Application');
      }
      runApp(MyApp(
        startWidget: widget,
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    this.startWidget,
    this.isDark,
  }) : super(key: key);
  final bool? isDark;
  Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeDarkMode(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getCategoriesData()
            ..getHomeData()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: startWidget,
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
