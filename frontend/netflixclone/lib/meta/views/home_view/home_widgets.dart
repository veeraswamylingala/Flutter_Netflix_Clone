import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/models/moviemodel.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/app/routes/routes.dart';
import 'package:netflixclone/app/shared/colors.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/fonts.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:getwidget/getwidget.dart';

// final List<String> imageList = [
//   "https://milnersblog.files.wordpress.com/2016/11/new-rogue-one-a-star-wars-story-film-banners-the-rebel-alliance.jpg"
//       "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
// ];

final List<String> imageList = [
  "https://raw.githubusercontent.com/veeraswamylingala/netflixClonePosters/main/movie1.jpg",
  "https://raw.githubusercontent.com/veeraswamylingala/netflixClonePosters/main/movie2.jpg",
  "https://raw.githubusercontent.com/veeraswamylingala/netflixClonePosters/main/movie3.jpg",
  "https://raw.githubusercontent.com/veeraswamylingala/netflixClonePosters/main/movie4.jpg",
  "https://raw.githubusercontent.com/veeraswamylingala/netflixClonePosters/main/movie5.jpg"
];

resposiveTitleBox(MovieModel movie, BuildContext context) {
  return Container(
    // color: Colors.green,
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width * 0.75,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(movie.moviename, style: smalltextB),
        ),
        Row(
          children: [
            Text(
              movie.movieyear,
              style: TextStyle(color: Colors.white54),
            ),
            Container(
                height: 20, child: VerticalDivider(color: Colors.white54)),
            Text(
              movie.moviecategory,
              style: TextStyle(color: Colors.white54),
            ),
            Container(
                height: 20, child: VerticalDivider(color: Colors.white54)),
            movie.ismovie == false
                ? Text(
                    "${movie.showepisodes.length.toString()} Episodes",
                    style: TextStyle(color: Colors.white54),
                  )
                : Text(
                    "2h 38m",
                    style: TextStyle(color: Colors.white54),
                  )
          ],
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            children: [
              Text(
                "Starring : ",
                style: TextStyle(color: Colors.white54),
              ),
              Text(
                textSelect(movie.moviestarcast.toString()),
                style: TextStyle(color: Colors.white54),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget titlesBox(MovieModel movie, BuildContext context) {
  return Container(
    // color: Colors.blue,
    //color: Colors.green,
    height: MediaQuery.of(context).size.height * 0.25,
    width: MediaQuery.of(context).size.width * 0.35,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            movie.moviename,
            style: smalltextHuge,
          ),
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            children: [
              Text(
                movie.movieyear,
                style: normalTextwithDark,
              ),
              Container(
                  height: 20, child: VerticalDivider(color: Colors.white54)),
              Text(
                movie.moviecategory,
                style: normalTextwithDark,
              ),
              Container(
                  height: 20, child: VerticalDivider(color: Colors.white54)),
              movie.ismovie == false
                  ? Text(
                      "${movie.showepisodes.length.toString()} Episodes",
                      style: normalTextwithDark,
                    )
                  : Text(
                      "2h 38m",
                      style: normalTextwithDark,
                    )
            ],
          ),
        ),
        Flexible(
          child: Text(
            movie.moviedescription,
            maxLines: 3,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.01,
                fontWeight: FontWeight.normal,
                color: lightColor,
                fontFamily: MONTSERRAT),
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
  );
}

textSelect(String name) {
  name = name.replaceAll("[", "");
  name = name.replaceAll("]", "");

  return name;
}
