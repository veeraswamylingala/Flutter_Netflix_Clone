import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/routes/routes.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _createHeader(),
        _createDrawerItem(
          icon: Icons.contacts,
          text: 'Home',
          onTap: () {
            Navigator.pushNamed(context, HomeRoute);
          },
        ),
        _createDrawerItem(
          icon: Icons.event,
          text: 'Movies',
          onTap: () {
            Navigator.pushNamed(context, MoviesRoute);
          },
        ),
        _createDrawerItem(
          icon: Icons.note,
          text: 'Series',
          onTap: () {
            Navigator.pushNamed(context, SeriesRoute);
          },
        ),
        _createDrawerItem(
          icon: Icons.note,
          text: 'My List',
          onTap: () {},
        ),
        Container(height: 20, child: Divider(color: Colors.black)),
        _createDrawerItem(
          icon: Icons.note,
          text: 'KIDS',
          onTap: () {},
        ),
        _createDrawerItem(
          icon: Icons.note,
          text: 'DVD',
          onTap: () {},
        ),
        Container(height: 20, child: Divider(color: Colors.black)),
        _createDrawerItem(
          icon: Icons.exit_to_app,
          text: 'Singout',
          onTap: () {
            Navigator.pushReplacementNamed(context, LandingRoute);
          },
        ),
      ],
    ),
  );
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.black,
        // image: DecorationImage(
        //     image: AssetImage("web/logo1.jpeg"), fit: BoxFit.cover),
      ),
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 12.0,
          left: 16.0,
          child: Container(
            height: 100,
            width: 150,
            child: Image.asset(
              "web/logo1.png",
              fit: BoxFit.fitWidth,
            ),
          ),

          //  Text("Netflicx ",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20.0,
          //         fontWeight: FontWeight.w500))
        ),
      ]));
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
