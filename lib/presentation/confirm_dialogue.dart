import 'package:darkgreen/constant/color.dart';
import 'package:flutter/material.dart';



Future<bool> showConfirmationDialog(
    BuildContext context, {
      required String heading,
      required String name,
      required String message,
      bool isConfirmationDialog = false,
    }) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),),
      title: Text(heading),
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: CommonColor.APP_BAR_COLOR
                )),
            TextSpan(text: message,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: CommonColor.BLACK_COLOR
                )),
          ],
        ),
      )
    ),
  )) ??
      false;
}
