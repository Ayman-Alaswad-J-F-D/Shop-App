// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:conditional_builder/conditional_builder.dart';
import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProducts(
              ShopCubit.get(context)
                  .favoritesModel!
                  .data!
                  .data![index]
                  .product!,
              context,
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              color: Colors.deepOrangeAccent,
              thickness: 0.2,
              height: 25,
            ),
            itemCount:
                ShopCubit.get(context).favoritesModel?.data?.data?.length ?? 0,
          ),
          fallback: (contetx) => Center(
            child: Lottie.asset(
              'assets/images/welcome-loading-animation.json',
              height: 200,
              width: 200,
            ),
          ),
        );
      },
    );
  }
}
