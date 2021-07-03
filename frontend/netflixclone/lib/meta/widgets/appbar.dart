import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/app/routes/routes.dart';
import 'package:netflixclone/app/shared/text_styles.dart';

Widget widgetAppBar(BuildContext context) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: ResponsiveWidget.isMediumScreen(context)
          ? AppBar(
              backgroundColor: Colors.blueGrey.shade900.withOpacity(0),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              centerTitle: false,
              title: Container(
                height: 50,
                width: 120,
                child: Image.asset(
                  "web/logo1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
              ],
            )
          : AppBar(
              leadingWidth: 650,
              backgroundColor: Color(0x44000000),
              leading: Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      child: Image.asset(
                        "web/logo1.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          print("Home Tapped");
                          Navigator.pushNamed(context, HomeRoute);
                        },
                        child: Text(
                          "Home",
                          style: smalltextR,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SeriesRoute);
                        },
                        child: Text(
                          "Series",
                          style: smalltextR,
                        )),
                    TextButton(
                        onPressed: () {
                          print("Movies Tapped");
                          Navigator.pushNamed(context, MoviesRoute);
                        },
                        child: Text(
                          "Movies",
                          style: smalltextR,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "My List",
                          style: smalltextR,
                        )),
                  ],
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "KIDS",
                      style: smalltextR,
                    )),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "DVD",
                      style: smalltextR,
                    )),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 100,
                      color: Colors.red,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LandingRoute);
                            //   Navigator.pushNamed(context, LandingRoute);
                            //      loginPopup(context: context);
                          },
                          child: Text(
                            "Sign Out",
                            style: smalltextR,
                          ))),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ));
}
