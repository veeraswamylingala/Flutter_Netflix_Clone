import 'package:flutter/material.dart';
import 'package:netflixclone/app/routes/routes.dart';
import 'package:netflixclone/core/notifiers/fetchmovies..notifier.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/notifiers/authentication.notifier.dart';

void main() {
  //it will removes # in Url
  setPathUrlStrategy();

  runApp(core());
}

class core extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenticationNotifier>(
              create: (_) => AuthenticationNotifier()),
          ChangeNotifierProvider<MovieNotifier>(create: (_) => MovieNotifier()),
        ],
        child: MaterialApp(
          initialRoute: LandingRoute,
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: 'NetflixClone',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
        ));
  }
}
