import 'package:http/http.dart' as http;
import 'package:movie_db/models/cast.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/models/resp_cast.dart';
import 'package:movie_db/models/result.dart';

class API {
  final String _baseURL = "https://api.themoviedb.org/3";
  static const String imageURL = "https://image.tmdb.org/t/p/original";
  final String _apiKey = "cc6e1fbfdd21d3f2fab3fc2d59d7c88c";

  Future<List<Movie>> getList(String url, {String param = ""}) async {
    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apiKey&$param"),
    );

    if (response.statusCode == 200) {
      var rep = Result.fromRawJson(response.body);

      return rep.results;
    } else {
      throw Exception("Fail to load Movies");
    }
  }

  Future<List<Movie>> getPopular() async {
    return getList("/movie/popular");
  }

  Future<List<Movie>> getNowPlaying() async {
    return getList("/movie/now_playing");
  }

  Future<List<Movie>> getSearch(String name) async {
    return getList("/search/movie", param: "query=$name");
  }

  Future<List<Movie>> getRecomd(int movieID) async {
    return getList("/movie/$movieID/recommendations");
  }

  Future<List<Cast>> getCast(int movieID) async {
    var url = "/movie/$movieID/credits";

    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      var rep = RespCast.fromRawJson(response.body);
      return rep.cast;
    } else {
      throw Exception("Fail to load Movies");
    }
  }
}
