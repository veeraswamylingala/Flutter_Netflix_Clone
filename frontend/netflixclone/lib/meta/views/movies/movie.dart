import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/models/moviemodel.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/meta/views/home_view/home_widgets.dart';
import 'package:netflixclone/meta/widgets/appbar.dart';
import 'package:netflixclone/meta/widgets/drawer.dart';

class Movie extends StatefulWidget {
  final MovieModel movie;

  Movie(this.movie);
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: widgetAppBar(context)),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height + 200,
                alignment: FractionalOffset.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.movie.moviethumbnailurl,
                      ),
                      fit: BoxFit.cover),
                  color: Colors.black,
                ),
                child: ResponsiveWidget.isSmallScreen(context)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: resposiveTitleBox(widget.movie, context)),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: titlesBox(widget.movie, context)),
                      ),
              ),
              SizedBox(
                height: 200,
              )
            ]),
          )),
    );
  }
}
