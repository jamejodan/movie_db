import 'package:flutter/material.dart';
import 'package:movie_db/components/movie_list.dart';
import 'package:movie_db/components/search_list.dart';
import 'package:movie_db/controller/homepage_controller.dart';
import 'package:movie_db/models/movie.dart';
import 'package:get/get.dart';

import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController c = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    c.loadPopular();
    c.loadNowPlaying();
  }

  Widget popularList() => c.popularMovies.isEmpty
      ? const CircularProgressIndicator()
      : Movielist(list: c.popularMovies, title: "Popular Movies", extra: "1");

  Widget nowPlayingList() => c.nowPlayingMovies.isEmpty
      ? const CircularProgressIndicator()
      : Movielist(
          list: c.nowPlayingMovies, title: "Now Playing Movies", extra: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies DB'),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(SearchPage());
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Obx(() {
          return Column(
            children: [
              popularList(),
              nowPlayingList(),
            ],
          );
        }));
  }
}
