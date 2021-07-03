import 'package:netflixclone/meta/views/home_view/home.dart';
import 'package:netflixclone/meta/views/landing_View/landing_view.dart';
import 'package:netflixclone/meta/views/movies/movies_view.dart';
import 'package:netflixclone/meta/views/series/allseries_view.dart';
import 'package:netflixclone/meta/views/series/series_view.dart';

const String LandingRoute = "/landing";
const String HomeRoute = "/homeview";
const String MoviesRoute = "/moviesview";
const String SeriesRoute = "/seriesview";
// const String SingleSeriesRoute = "/seriesview/new";

final routes = {
  LandingRoute: (context) => LandingView(),
  HomeRoute: (context) => HomeView(),
  MoviesRoute: (context) => MoviesView(),
  SeriesRoute: (context) => AllSeriesView(),
};
