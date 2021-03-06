import 'package:flutter/material.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';
import 'package:get/get.dart';
import 'package:movie_db/pages/detail_page.dart';

// ignore: must_be_immutable
class MovieList extends StatelessWidget {
  List<Movie> list;

  MovieList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        Movie m = list[index];
        return InkWell(
          onTap: () {
            Get.to(
              DetailPage(movie: m, extra: ''),
            );
          },
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: Image.network(API.imageURL + m.posterPath),
                ),
                Text(
                  m.title,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
