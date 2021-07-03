import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/text_styles.dart';

customTextField(
    {required String hintText,
    required double width,
      required bool obscureText, required TextEditingController textEditingController}) {
  return Container(
    width: width,
    child: TextFormField(
      validator:(value){
        if(value!.isEmpty)
          {
            return "Data must be Requires!";
          }else
            {
              return null;
            }
      },

      obscureText: obscureText,
      obscuringCharacter: "*",
      style: smalltextR,
      controller: textEditingController,
      decoration: InputDecoration(

          border:
              OutlineInputBorder(borderSide: new BorderSide(color: redColor)),
          hintText: hintText,
          hintStyle: smalltextR),
    ),
  );
}
