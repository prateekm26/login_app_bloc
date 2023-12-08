import 'package:flutter/material.dart';
import 'package:loginapp/src/data_layer/res/colors.dart';
import 'package:loginapp/src/data_layer/res/numbers.dart';
import 'package:loginapp/src/data_layer/res/styles.dart';

class CommonAppButton extends StatelessWidget {
  CommonAppButton(
      {super.key, required this.title, this.onPressed, this.disable = false});

  final String title;
  final VoidCallback? onPressed;
  bool disable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: d_50,
      margin: AppStyles.pd8,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(d_0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(d_15),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(disable
              ? AppColors.mainColor.withOpacity(0.5)
              : AppColors.mainColor),
        ),
        onPressed: disable ? null : onPressed,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.whiteLightBold20,
          ),
        ),
      ),
    );
  }
}
