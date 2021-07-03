import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:netflixclone/meta/views/authentication/send_verificationemail.popup.dart';
import 'package:netflixclone/meta/views/authentication/verify_mail_popup.dart';
import 'package:netflixclone/meta/views/login/login_popup.dart';
import 'package:netflixclone/meta/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = "";
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Color(0x44000000),
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              "web/logo1.png",
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: width * 0.10,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: TextButton(
                      onPressed: () {
                        //      showSendVerificationEmailPopup(context: context);
                      },
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "English ",
                          style: smalltextR,
                        ),
                      ))),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: width * 0.10,
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        loginPopup(context: context);
                      },
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Sign In",
                          style: smalltextR,
                        ),
                      ))),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Center(
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("web/homepagebackground.jpeg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.srgbToLinearGamma())),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Unlimited movies, TV ",
                        style: smalltextHuge,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "shows and more.",
                        style: smalltextHuge,
                      ),
                    ),
                    vSizedBox2,
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Watch anywhere. Cancel anytime.",
                        style: smalltextB,
                      ),
                    ),
                    vSizedBox2,
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Ready to watch? Enter your email to create or restart your membership.",
                        style: smalltextB,
                      ),
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white,
                                height: 60,
                                width: width * 0.4,
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Data must be Required!";
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscuringCharacter: "*",
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.black)),
                                      hintText: "Email Address",
                                      labelText: "Email Address",
                                      hintStyle: smalltextR),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ]),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.white)),
                            // width: width * 0.15,
                            height: 60,
                            child: TextButton(
                                onPressed: () {
                                  if (emailController.text != "") {
                                    print(emailController.text);
                                    setState(() {
                                      errorMessage = "";
                                      loading = true;
                                    });
                                    Provider.of<AuthenticationNotifier>(context,
                                            listen: false)
                                        .sendVerificationEmail(
                                            userEmail: emailController.text)
                                        .then((value) {
                                      print("data");
                                      print(value['received']);
                                      if (value['received'] == true) {
                                        setState(() {
                                          loading = false;
                                        });

                                        verfityMailPopup(context: context);
                                      } else {
                                        setState(() {
                                          loading = false;
                                          errorMessage = value['useremail'];
                                        });
                                      }
                                      print(value);
                                    });
                                  } else {
                                    setState(() {
                                      errorMessage = "Email must be Required";
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Get Started ",
                                        style: smalltextR,
                                      ),
                                    ),
                                    loading
                                        ? Container(
                                            height: 20.0,
                                            width: 20.0,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              value: 1,
                                            ))
                                        : vSizedBox0
                                  ],
                                ))),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
