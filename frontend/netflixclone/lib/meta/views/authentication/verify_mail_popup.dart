import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:netflixclone/meta/views/authentication/userDetails_popup.dart';
import 'package:netflixclone/meta/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

//LAYOUTBUIDER
//RESPONSEIVEBUILDER
//MEDIAQUERY

verfityMailPopup({required BuildContext context}) {
  final otpverifyTextfieldController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        bool loading = false;
        String errorMessage = "";
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Builder(
              builder: (context) => Container(
                height: 500,
                width: 400,
                color: Color.fromRGBO(0, 0, 0, 0.7),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: lightColor,
                                  )),
                            ],
                          ),
                          Text(
                            "Verify OTP",
                            style: smalltextB,
                          ),
                          vSizedBox2,
                          Text(
                            "Enter OTP that sent to your mail : ",
                            style: smalltextR,
                          ),
                          Text(
                            "${Provider.of<AuthenticationNotifier>(context, listen: true).useremail}",
                            style: smalltextR,
                          ),
                          vSizedBox3,
                          customTextField(
                              obscureText: false,
                              width: 300,
                              textEditingController:
                                  otpverifyTextfieldController,
                              hintText: "Enter otp"),
                          vSizedBox3,
                          Container(
                            width: 300,
                            height: 40,
                            color: Colors.redAccent,
                            child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                      errorMessage = "";
                                    });
                                    Provider.of<AuthenticationNotifier>(context,
                                            listen: false)
                                        .verifyOTP(
                                            userOTP:
                                                otpverifyTextfieldController
                                                    .text)
                                        .then((value) {
                                      print(value);
                                      if (value['verified'] == true) {
                                        Navigator.pop(context);
                                        userDetailsPopup(context: context);
                                        //Move to Home
                                      } else {
                                        setState(() {
                                          loading = false;
                                          errorMessage = "Invalid OTP";
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          ),

                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                          vSizedBox3,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Resend",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                              Text("OTP ?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          ),
                          vSizedBox2,

                          loading ? CircularProgressIndicator() : SizedBox()
                          // Text()
                        ]),
                  ),
                  physics: ClampingScrollPhysics(),
                ),
              ),
            ),
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
      });
}
