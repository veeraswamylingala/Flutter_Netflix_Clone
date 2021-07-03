import 'package:flutter/material.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/meta/views/home_view/home_widgets.dart';

Widget moviesBar() {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
    child: Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Movies",
              style: smalltextR,
            )),
        Container(
          height: 175,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('${imageList[index]}')),
                              color: Colors.white),
                          height: 150,
                          width: 300,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Movie  ${index}",
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
  );
}
