import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:netflixclone/app/models/moviemodel.dart';
import 'package:netflixclone/app/routes/api.routes.dart';

class MovieNotifier extends ChangeNotifier {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  late List<MovieModel> movies = [];

//fetchMovies ------------------------

  Future FetchMovies() async {
    final String subUrl = "/movie/fetch-movies";
    final Uri uri = Uri.parse(BaseUrl + subUrl);
    final http.Response response = await client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsedData = json.decode(response.body);

      movies = List<MovieModel>.from(
          parsedData['data'].map((i) => MovieModel.fromJson(i)));
    }
    notifyListeners();
    return movies;
  }

  ///send Email Verification----------------
  Future fetchMoviesbyCategory(String category) async {
    print(category);
    List<MovieModel> catMovies = [];

    final String subUrl = "/movie/category/${category}";
    final Uri uri = Uri.parse(BaseUrl + subUrl);

    print(uri);
    final http.Response response = await client.get(uri);
    final String body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final Map parsedData = await jsonDecode(body);
      print("Length of ${category} Movies: ${parsedData['data'].length}");
      if (parsedData['data'].length != 0) {
        catMovies = List<MovieModel>.from(
            parsedData['data'].map((i) => MovieModel.fromJson(i)));
        print(catMovies.length);
      }
    }
    notifyListeners();
    return catMovies;
  }
}
