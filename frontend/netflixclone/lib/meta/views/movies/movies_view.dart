import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/models/moviemodel.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/core/notifiers/fetchmovies..notifier.dart';
import 'package:netflixclone/meta/views/home_view/home_widgets.dart';
import 'package:netflixclone/meta/views/movies/movie.dart';
import 'package:netflixclone/meta/widgets/appbar.dart';
import 'package:netflixclone/meta/widgets/drawer.dart';
import 'package:provider/provider.dart';

class MoviesView extends StatefulWidget {
  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  void initState() {
    Provider.of<MovieNotifier>(context, listen: false).FetchMovies();
    super.initState();
  }

  String textSelect(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(context),
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.black87,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: widgetAppBar(context)),
        body: Container(
          padding: EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // vSizedBox2,
              // Text(
              //   "Movies",
              //   style: smalltextB,
              // ),
              vSizedBox2,
              Consumer<MovieNotifier>(
                builder: (context, MoviesData, child) => Expanded(
                    child: MoviesData.movies.isNotEmpty
                        ? ListView.builder(
                            itemCount: MoviesData.movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MoviesData.movies[index].ismovie
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Movie(
                                                    MoviesData.movies[index])));
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 10),
                                          child: ResponsiveWidget.isSmallScreen(
                                                  context)
                                              ? responsiveMovieList(context,
                                                  MoviesData.movies[index])
                                              : Container(
                                                  height: 250,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: Colors.black12,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    '${MoviesData.movies[index].moviethumbnailurl}')),
                                                            color:
                                                                Colors.white),
                                                        height: 250,
                                                        width: 400,
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
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
                                                      Container(
                                                          height: 200,
                                                          width: 20,
                                                          child:
                                                              VerticalDivider(
                                                                  color: Colors
                                                                      .white)),
                                                      Container(
                                                        width: 500,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              MoviesData
                                                                  .movies[index]
                                                                  .moviename,
                                                              style: smalltextB,
                                                            ),
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                MoviesData
                                                                    .movies[
                                                                        index]
                                                                    .moviedescription,
                                                                maxLines: 10,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    normalText,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  MoviesData
                                                                      .movies[
                                                                          index]
                                                                      .movieyear,
                                                                  style:
                                                                      normalText,
                                                                ),
                                                                Container(
                                                                    height: 20,
                                                                    child: VerticalDivider(
                                                                        color: Colors
                                                                            .white)),
                                                                Text(
                                                                  MoviesData
                                                                      .movies[
                                                                          index]
                                                                      .moviecategory,
                                                                  style:
                                                                      normalText,
                                                                ),
                                                                Container(
                                                                    height: 20,
                                                                    child: VerticalDivider(
                                                                        color: Colors
                                                                            .white)),
                                                                Text(
                                                                  "2h 38m",
                                                                  style:
                                                                      normalText,
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Starring : ",
                                                                  style:
                                                                      normalTextwithDark,
                                                                ),
                                                                Text(
                                                                  textSelect(MoviesData
                                                                      .movies[
                                                                          index]
                                                                      .moviestarcast
                                                                      .toString()),
                                                                  style:
                                                                      normalText,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                    )
                                  : SizedBox();
                            })
                        : Center(child: CircularProgressIndicator())),
              ),
            ],
          ),
        ));
  }
}

// Widget cat(String cat, BuildContext context) {
//   List<MovieModel> catMovie = [];
//   Provider.of<MovieNotifier>(context, listen: false)
//       .fetchMoviesbyCategory(cat)
//       .then((value) => {
//             if (value.length != 0) {print(value.length), catMovie = value}
//           });

//   return catMovie.isNotEmpty
//       ? Container(
//           height: 500,
//           color: Colors.black26,
//           child: moviesBar(),
//         )
//       : SizedBox();
// }

Widget responsiveMovieList(BuildContext context, MovieModel movie) {
  return Container(
    // height: 450,
    width: MediaQuery.of(context).size.width,
    color: Colors.black12,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          //Movie ThumbNail
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${movie.moviethumbnailurl}')),
              color: Colors.white),
          height: 250,
          width: 400,
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
        //Divider
        //Details Box
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  movie.moviename,
                  style: smalltextB,
                ),
              ),
              // FittedBox(
              //   fit: BoxFit.fitWidth,
              //   child: Text(
              //     movie.moviedescription,
              //     maxLines: 10,
              //     overflow: TextOverflow.ellipsis,
              //     style: normalText,
              //   ),
              // ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      movie.movieyear,
                      style: normalText,
                    ),
                    Container(
                        height: 20,
                        child: VerticalDivider(color: Colors.white)),
                    Text(
                      movie.moviecategory,
                      style: normalText,
                    ),
                    Container(
                        height: 20,
                        child: VerticalDivider(color: Colors.white)),
                    Text(
                      "2h 38m",
                      style: normalText,
                    )
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      "Starring : ",
                      style: normalTextwithDark,
                    ),
                    Text(
                      textSelect(movie.moviestarcast.toString()),
                      style: normalText,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Movie(movie)));
                },
                child: Text(
                  "Watch",
                  style: TextStyle(color: Colors.white),
                ))),
        Container(child: Divider(color: Colors.white)),
      ],
    ),
  );
}
