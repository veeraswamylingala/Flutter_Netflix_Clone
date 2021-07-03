import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/routes/routes.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:netflixclone/meta/views/home_view/home.dart';
import 'package:netflixclone/meta/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

loginPopup({required BuildContext context}) {
  final userPasswordController = TextEditingController();
  final userEmailController = TextEditingController();
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
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 38),
                        ),
                        vSizedBox3,
                        customTextField(
                            obscureText: false,
                            width: 300,
                            textEditingController: userEmailController,
                            hintText: "Enter UserEmail"),
                        vSizedBox2,
                        customTextField(
                            obscureText: true,
                            width: 300,
                            textEditingController: userPasswordController,
                            hintText: "Enter Password"),
                        vSizedBox2,

                        Container(
                            color: Colors.red,
                            width: 300,
                            height: 40,
                            child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                      errorMessage = "";
                                    });
                                    Provider.of<AuthenticationNotifier>(context,
                                            listen: false)
                                        .loginNotifier(
                                            userPassword:
                                                userPasswordController.text,
                                            userEmail: userEmailController.text)
                                        .then((value) {
                                      ///on successful Login
                                      if (value['processed'] == true) {
                                        Navigator.pop(context);
                                        //Named Routing
                                        Navigator.pushNamed(context, HomeRoute);
                                        //Normal Routing
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HomeView()));
                                      } else {
                                        setState(() {
                                          loading = false;
                                          errorMessage = value['data'];
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ))),
                        Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),

                        vSizedBox2,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New to Netflix? ",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15)),
                            Text("Sign up now.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))
                          ],
                        ),
                        vSizedBox2,
                        loading ? CircularProgressIndicator() : vSizedBox1,
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
