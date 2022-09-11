// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/layout/cubit/shop_app_states.dart';
import 'package:experiences_app/models/shop/categories_model.dart';
import 'package:experiences_app/models/shop/home_model.dart';
import 'package:experiences_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProdactsScreen extends StatelessWidget {
  const ProdactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => prodactBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) => Center(
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

  Widget prodactBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  // color: Colors.grey.shade50.withOpacity(0.95),
                  gradient: LinearGradient(colors: [
                    Colors.grey.shade50.withOpacity(0.80),
                    Colors.grey.shade50.withOpacity(0.99),
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: CarouselSlider(
                  items: model.data?.banners
                      .map(
                        (e) => Image.network(
                          '${e.image}',
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) {
                            return Center(
                              child: Lottie.asset(
                                'assets/images/welcome-loading-animation.json',
                                height: 100,
                                width: 100,
                              ),
                            );
                          },
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    pauseAutoPlayOnTouch: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    viewportFraction: 1.0,
                    height: 250.0,
                    initialPage: 2,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.orangeAccent.shade700,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 115,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                        )
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => builderCategories(
                          categoriesModel.data!.data[index],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10.0),
                        itemCount: categoriesModel.data!.data.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.deepPurple,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.1,
                  crossAxisSpacing: 1.1,
                  childAspectRatio: 1 / 1.72,
                  children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridProdact(model.data!.products[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProdact(ProductModel model, context) => Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1.6,
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Image.network(
                      model.image!,
                      width: double.infinity,
                      height: 200.0,
                      errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Lottie.asset(
                              'assets/images/welcome-loading-animation.json',
                              height: 100,
                              width: 100,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.5,
                        vertical: 1.5,
                      ),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black,
                              offset: Offset(-1.4, 1.4),
                              blurRadius: 3.5,
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 11.0, right: 11.0, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.0,
                        height: 1.3,
                      ),
                    ),
                    const Divider(color: Colors.deepPurple),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${model.price.round()} \$',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                          if (model.discount != 0)
                            const SizedBox(
                              width: 15,
                              child: Divider(
                                color: Colors.blue,
                                indent: 2.5,
                                endIndent: 4,
                              ),
                            ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: 24,
                            height: 21,
                            child: IconButton(
                              color: Colors.deepPurple,
                              padding: EdgeInsets.zero,
                              alignment: Alignment.bottomCenter,
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    ShopCubit.get(context).favorites[model.id]!
                                        ? defaultColor
                                        : Colors.grey.shade300,
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                ShopCubit.get(context)
                                    .changeFavoritess(model.id!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget builderCategories(DataModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
            )
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.network(
              model.image!,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return Center(
                  child: Lottie.asset(
                    'assets/images/welcome-loading-animation.json',
                    height: 80,
                    width: 80,
                  ),
                );
              },
              height: 117,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: 103,
              height: 37,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrangeAccent.withOpacity(0.0),
                    Colors.deepOrangeAccent.shade400.withOpacity(0.75),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 19),
                child: Text(
                  model.name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
