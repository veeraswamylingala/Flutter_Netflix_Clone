import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:netflixclone/meta/views/authentication/verify_mail_popup.dart';
import 'package:netflixclone/meta/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

showSendVerificationEmailPopup({required BuildContext context}) {
  final verificationEmailController = TextEditingController();
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
                          "Sign up",
                          style: smalltextR,
                        ),
                        vSizedBox2,
                        Text(
                          "Create a free account for getting started",
                          style: smalltextB,
                        ),
                        vSizedBox3,
                        customTextField(
                            obscureText: false,
                            width: 400,
                            textEditingController: verificationEmailController,
                            hintText: "Enter mail"),
                        vSizedBox3,
                        Container(
                          width: 400,
                          color: Colors.redAccent,
                          child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  print(verificationEmailController.text);
                                  setState(() {
                                    errorMessage = "";
                                    loading = true;
                                  });
                                  Provider.of<AuthenticationNotifier>(context,
                                          listen: false)
                                      .sendVerificationEmail(
                                          userEmail:
                                              verificationEmailController.text)
                                      .then((value) {
                                    print("data");
                                    print(value['received']);
                                    if (value['received'] == true) {
                                      Navigator.pop(context);
                                      verfityMailPopup(context: context);
                                    } else {
                                      setState(() {
                                        loading = false;
                                        errorMessage = value['useremail'];
                                      });
                                    }
                                    print(value);
                                  });
                                }
                              },
                              child: Text(
                                "Send Mail",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                        ),
                        vSizedBox3,
                        Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                        loading ? CircularProgressIndicator() : vSizedBox1,
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
