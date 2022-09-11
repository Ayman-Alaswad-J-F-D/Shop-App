// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:conditional_builder/conditional_builder.dart';
import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/models/shop/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).categoriesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => builderCatItem(
              ShopCubit.get(context).categoriesModel!.data!.data[index],
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              color: Colors.deepOrangeAccent,
              thickness: 0.2,
            ),
            itemCount:
                ShopCubit.get(context).categoriesModel?.data?.data.length ?? 0,
          ),
          fallback: (context) => Center(
            child: Lottie.asset(
              'assets/images/welcome-loading-animation.json',
              width: 200,
              height: 200,
            ),
          ),
        );
      },
    );
  }

  Widget builderCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                height: 120,
                width: 120,
                child: Image.network(
                  model.image ?? '',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return Center(
                      child: Lottie.asset(
                        'assets/images/welcome-loading-animation.json',
                        height: 60,
                        width: 60,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 20,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              const Icon(
                Icons.navigate_next,
                size: 25,
                color: Colors.deepOrangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
