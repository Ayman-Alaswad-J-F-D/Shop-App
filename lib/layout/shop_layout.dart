// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/modules/Search/search_screen.dart';
import 'package:experiences_app/shared/components/components.dart';
// import 'package:experiences_app/modules/Login/login_screen.dart';
// import 'package:experiences_app/shared/components/components.dart';
// import 'package:experiences_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ShopLayout extends StatelessWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: Text(
              cubit.titels[cubit.currentIndex],
              style: const TextStyle(color: Colors.deepPurple),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Shop.png'),
                radius: 20,
              ),
            ),
            leadingWidth: 65,
            actions: [
              TextButton(
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.assignment_ind_rounded,
                  ),
                  label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
