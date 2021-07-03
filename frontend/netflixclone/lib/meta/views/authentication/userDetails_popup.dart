import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:netflixclone/meta/views/login/login_popup.dart';
import 'package:netflixclone/meta/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

userDetailsPopup({required BuildContext context}) {
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userEmailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        userEmailController.text =
            Provider.of<AuthenticationNotifier>(context).useremail;
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
                          "User Details",
                          style: smalltextB,
                        ),
                        // vSizedBox2,
                        // Text(
                        //   "Enter usernaem : ${Provider.of<AuthenticationNotifier>(context,
                        //       listen: true)
                        //       .useremail}",
                        //   style: smalltextB,
                        // ),
                        vSizedBox3,
                        Container(
                          width: 300,
                          child: TextField(
                            readOnly: true,
                            enableInteractiveSelection:
                                false, // will disable paste operatio
                            style: smalltextR,
                            controller: userEmailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: redColor)),
                                hintText: "Your Email",
                                hintStyle: smalltextR),
                          ),
                        ),

                        vSizedBox2,
                        customTextField(
                            obscureText: false,
                            width: 300,
                            textEditingController: userNameController,
                            hintText: "Enter UserName"),
                        vSizedBox2,
                        customTextField(
                            obscureText: true,
                            width: 300,
                            textEditingController: userPasswordController,
                            hintText: "Enter Password"),
                        vSizedBox2,

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
                                    .saveData(
                                        username: userNameController.text,
                                        userPassword:
                                            userPasswordController.text)
                                    .then((value) {
                                  if (value['authentication'] == true) {
                                    Navigator.pop(context);
                                    loginPopup(context: context);
                                  } else {
                                    setState(() {
                                      loading = false;
                                      errorMessage =
                                          "Error in Saving Data :Try Again";
                                    });
                                  }
                                });
                              }
                            },
                            child: Text("Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ),
                        ),
                        Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                        vSizedBox3,
                        loading ? CircularProgressIndicator() : SizedBox()

                        // Text()
                      ],
                    ),
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
