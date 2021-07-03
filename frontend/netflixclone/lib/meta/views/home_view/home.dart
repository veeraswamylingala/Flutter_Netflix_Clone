import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflixclone/core/notifiers/fetchmovies..notifier.dart';
import 'package:netflixclone/meta/widgets/appbar.dart';
import 'package:netflixclone/meta/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'home_widgets.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<MovieNotifier>(context, listen: false).FetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: widgetAppBar(context)),
        drawer: drawer(context),
        body: Consumer<MovieNotifier>(
          builder: (context, MoviesData, child) => MoviesData.movies.isNotEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Image Slider ----------------------part-1
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false,
                            autoPlay: true,
                            reverse: false,
                          ),
                          items: MoviesData.movies
                              .map((movie) => ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  movie.moviethumbnailurl,
                                                ),

                                                ///   colorFilter: ColorFilter.srgbToLinearGamma(),
                                                colorFilter: ColorFilter.mode(
                                                    Colors.grey,
                                                    BlendMode.modulate),
                                                fit: BoxFit.cover),
                                            color: Colors.black,
                                          ),
                                        ),
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 50, 10, 0),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: resposiveTitleBox(
                                                        movie, context)),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        50, 10, 10, 10),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: titlesBox(
                                                        movie, context)),
                                              )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                        vSizedBox2,
                        //Show Movies Section part-2
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Movies",
                                    style: smalltextR,
                                  )),
                              vSizedBox1,
                              Container(
                                height: 175,
                                child: ListView.builder(
                                    itemCount: MoviesData.movies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            '${MoviesData.movies[index].moviethumbnailurl}')),
                                                    color: Colors.white),
                                                height: 150,
                                                width: 300,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "web/logo.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${MoviesData.movies[index].moviename}",
                                                style: smalltextR,
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 20)
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Popular on Netflix",
                                    style: smalltextR,
                                  )),
                              vSizedBox1,
                              Container(
                                height: 180,
                                child: ListView.builder(
                                    itemCount: MoviesData.movies.length - 1,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            '${MoviesData.movies[index + 1].moviethumbnailurl}')),
                                                    color: Colors.white),
                                                height: 150,
                                                width: 300,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.asset(
                                                      "web/logo.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${MoviesData.movies[index + 1].moviename}",
                                                style: smalltextR,
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 20)
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              : Center(child: SizedBox(child: CircularProgressIndicator())),
        ));
  }
}
