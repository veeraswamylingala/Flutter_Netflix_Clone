import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/app/models/moviemodel.dart';
import 'package:netflixclone/app/responsive/responsive.dart';
import 'package:netflixclone/app/shared/dimensions.dart';
import 'package:netflixclone/app/shared/text_styles.dart';
import 'package:netflixclone/meta/views/home_view/home_widgets.dart';
import 'package:netflixclone/meta/widgets/appbar.dart';
import 'package:netflixclone/meta/widgets/drawer.dart';

class SeriesView extends StatefulWidget {
  final MovieModel movie;

  const SeriesView({Key? key, required this.movie}) : super(key: key);
  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: drawer(context),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: widgetAppBar(context)),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: ResponsiveWidget.isMediumScreen(context)
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height,
                  alignment: FractionalOffset.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.movie.moviethumbnailurl,
                        ),
                        // colorFilter:
                        //     ColorFilter.mode(Colors.grey, BlendMode.modulate),
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
                vSizedBox2,
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                    child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Episodes",
                              style: smalltextB,
                            ),
                            Container(
                                height: 20,
                                child: VerticalDivider(color: Colors.white54)),
                            Text(
                              widget.movie.moviename,
                              style: normalTextwithDark,
                            )
                          ],
                        ),
                        vSizedBox2,
                        Row(children: [
                          Text(
                            "Release year: ",
                            style: normalText,
                          ),
                          Text(
                            widget.movie.movieyear,
                            style: smalltextR,
                          ),
                        ]),
                        vSizedBox2,
                        Container(
                          alignment: Alignment.topLeft,
                          width: 500,
                          child: Text(
                            widget.movie.moviedescription,
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        vSizedBox2,
                        Container(
                          height: 250,
                          child: ListView.builder(
                              itemCount: widget.movie.showepisodes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '${widget.movie.showepisodes[index].showepisodethumbnail}')),
                                              color: Colors.white),
                                          height: 150,
                                          width: 300,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${index + 1}. ${widget.movie.showepisodes[index].showepisodename}",
                                          style: smalltextR,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 300,
                                            child: Text(
                                              widget.movie.showepisodes[index]
                                                  .showepisodedescription,
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12),
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 20)
                                  ],
                                );
                              }),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
