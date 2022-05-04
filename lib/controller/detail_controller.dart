import 'package:get/get.dart';
import 'package:movie_db/models/cast.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';

class DetailController extends GetxController {
  RxList<Cast> castList = <Cast>[].obs;
  RxList<Movie> recommendationList = <Movie>[].obs;

  void loadCastList(int movieId) {
    API().getCast(movieId).then((value) => castList.value = value);
  }

  void loadRecommendList(int movieId) {
    API().getRecomd(movieId).then((value) => recommendationList.value = value);
  }
}
