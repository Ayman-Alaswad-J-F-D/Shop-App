// import 'dart:ffi';

import 'package:experiences_app/layout/cubit/shop_app_cubit.dart';
import 'package:experiences_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget myTextFormField({
  required TextEditingController textEditingController,
  required TextInputType typeInput,
  required String label,
  double radius = 15.0,
  double gapPadding = 5.0,
  Icon? prefixIcon,
  IconData? suffixIcon,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  String? Function(String?)? validate,
  bool isPassword = false,
  bool filledNeed = false,
  Color fillColor = Colors.white,
  String? hintText,
  Color? colorHintText,
  Color? colorLableText,
  double? fontSizeHintText,
  bool? openEnabled = true,
  bool? openHelberText = false,
}) =>
    TextFormField(
      // scrollPhysics: const BouncingScrollPhysics(),
      style: const TextStyle(color: Colors.deepPurple),
      enabled: openEnabled,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      controller: textEditingController,
      keyboardType: typeInput,
      obscureText: isPassword,
      // style: const TextStyle(color: Colors.indigo),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        helperText: openHelberText! ? '  Please edit your information' : null,
        helperStyle: TextStyle(color: Colors.deepOrange.shade400),
        // disabledBorder: InputBorder.none,
        filled: filledNeed,
        fillColor: filledNeed ? fillColor : Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          color: colorLableText,
          fontFamily: 'Pacifico',
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorHintText,
          fontSize: fontSizeHintText,
          fontStyle: FontStyle.italic,
        ),
        border: InputBorder.none,
        // border: OutlineInputBorder(
        //   gapPadding: gapPadding,
        //   borderRadius: BorderRadius.all(Radius.circular(radius)),
        // ),
        prefixIcon: prefixIcon,

        suffixIcon: suffixIcon != null
            ? IconButton(
                // color: Colors.deepOrange.shade500,
                highlightColor: Colors.grey.shade50,
                onPressed: suffixPressed,
                icon: Icon(
                  suffixIcon,
                  color: Colors.deepOrange.shade500,
                ),
              )
            : null,
      ),
    );

Widget myButton({
  double width = double.infinity,
  double height = 37.0,
  Color backgound = Colors.deepPurple,
  // bool isUpperCase = true,
  EdgeInsetsDirectional? padding,
  double radius = 7.0,
  required Function() function,
  required Widget childOrText,
}) =>
    MaterialButton(
      // animationDuration: Duration(milliseconds: 100),
      elevation: 7,
      minWidth: width,
      height: height,
      // splashColor: Colors.deepOrange.shade500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: backgound,
      padding: padding,
      onPressed: function,
      child: childOrText,
      // Text(
      //    '',
      // style: const TextStyle(
      //   // height: 2,
      //   color: Colors.white,
      //   fontSize: 17,
      //   fontFamily: 'Pacifico',
      //   letterSpacing: 1,
      // ),
      // ),
    );

Widget myTextButton({
  required Function() finction,
  required String text,
  TextDecoration? lineInText,
  Key? uniqueKey,
  Color? colortext,
}) =>
    TextButton(
      key: uniqueKey,
      onPressed: finction,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: colortext,
          fontFamily: 'Pacifico',
          decoration: lineInText,
        ),
      ),
    );

void showToastLong({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 17.0,
    );

void showToastShort({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 17.0,
    );

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildPageOnBoardingScreen({
  required Color color,
  required Color colorText,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              urlImage,
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.high,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: colorText,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildListProducts(model, context, {bool? isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 125.0,
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
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                    bottom: 3,
                    left: 4,
                  ),
                  child: Container(
                    color: Colors.white,
                    width: 120.0,
                    height: 125.0,
                    child: Image.network(
                      model.image ?? '',
                      width: 120.0,
                      height: 125.0,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Center(
                          child: Lottie.asset(
                            'assets/images/welcome-loading-animation.json',
                            width: 80,
                            height: 30,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (model.discount != 0 && isOldPrice!)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(
                      left: 11,
                      right: 5,
                      top: 1.5,
                      bottom: 1.5,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
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
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.5,
                      // bottom: 1,
                      left: 5,
                      right: 35,
                    ),
                    child: Text(
                      model.name ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                        if (model.discount != 0 && isOldPrice!)
                          const SizedBox(
                            width: 15,
                            child: Divider(
                              color: Colors.blue,
                              indent: 3,
                              endIndent: 4,
                            ),
                          ),
                        if (model.discount != 0 && isOldPrice!)
                          Text(
                            model.oldPrice.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          color: Colors.deepPurple,
                          alignment: Alignment.bottomCenter,
                          icon: CircleAvatar(
                            radius: 13,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id] ??
                                        false
                                    ? defaultColor
                                    : Colors.grey.shade300,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            ShopCubit.get(context)
                                .changeFavoritess(model.id ?? 0);
                          },
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
