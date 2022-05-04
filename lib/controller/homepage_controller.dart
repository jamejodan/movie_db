import 'package:get/get.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';

class HomePageController extends GetxController {
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;

  loadPopular() {
    API().getPopular().then((value) {
      popularMovies.value = value;
    });
  }

  loadNowPlaying() {
    API().getNowPlaying().then((value) {
      nowPlayingMovies.value = value;
    });
  }
}
