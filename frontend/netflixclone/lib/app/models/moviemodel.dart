class MovieModel {
  List<String> moviestarcast = [];
  List<Showepisodes> showepisodes = [];
  String sId = '';
  String moviename = "";
  String moviedescription = "";
  String movietrailerurl = "";
  String moviethumbnailurl = "";
  String moviecategory = "";
  String movieyear = "";
  bool ismovie = false;
  int iV = 0;

  MovieModel(
      {required this.moviestarcast,
      required this.showepisodes,
      required this.sId,
      required this.moviename,
      required this.moviedescription,
      required this.movietrailerurl,
      required this.moviethumbnailurl,
      required this.moviecategory,
      required this.movieyear,
      required this.ismovie,
      required this.iV});

  MovieModel.fromJson(Map<String, dynamic> json) {
    moviestarcast = json['moviestarcast'].cast<String>();
    if (json['ismovie'] == false) {
      // ignore: deprecated_member_use
      showepisodes = List<Showepisodes>.from(
          json["showepisodes"].map((x) => Showepisodes.fromJson(x)));
    }
    sId = json['_id'];
    moviename = json['moviename'];
    moviedescription = json['moviedescription'];
    movietrailerurl = json['movietrailerurl'];
    moviethumbnailurl = json['moviethumbnailurl'];
    moviecategory = json['moviecategory'];
    movieyear = json['movieyear'];
    ismovie = json['ismovie'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moviestarcast'] = this.moviestarcast;
    if (this.showepisodes != null) {
      data['showepisodes'] = this.showepisodes.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['moviename'] = this.moviename;
    data['moviedescription'] = this.moviedescription;
    data['movietrailerurl'] = this.movietrailerurl;
    data['moviethumbnailurl'] = this.moviethumbnailurl;
    data['moviecategory'] = this.moviecategory;
    data['movieyear'] = this.movieyear;
    data['ismovie'] = this.ismovie;
    data['__v'] = this.iV;
    return data;
  }
}

class Showepisodes {
  String showepisodename = "";
  String showepisodedescription = "";
  String showepisodethumbnail = "";
  String showepisodetrailerurl = "";

  Showepisodes(
      {required this.showepisodename,
      required this.showepisodedescription,
      required this.showepisodethumbnail,
      required this.showepisodetrailerurl});

  Showepisodes.fromJson(Map<String, dynamic> json) {
    showepisodename = json['showepisodename'];
    showepisodedescription = json['showepisodedescription'];
    showepisodethumbnail = json['showepisodethumbnail'];
    showepisodetrailerurl = json['showepisodetrailerurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showepisodename'] = this.showepisodename;
    data['showepisodedescription'] = this.showepisodedescription;
    data['showepisodethumbnail'] = this.showepisodethumbnail;
    data['showepisodetrailerurl'] = this.showepisodetrailerurl;
    return data;
  }
}
