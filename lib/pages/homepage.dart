import 'package:flutter/material.dart';
import 'package:movie_db/components/movie_list.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';

import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? moviesPopular;

  List<Movie>? nowPlayingMovie;

  loadPopular() {
    API().getPopular().then((value) {
      setState(() {
        moviesPopular = value;
      });
    });

    API().getNowPlaying().then((value) {
      setState(() {
        nowPlayingMovie = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies DB'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          moviesPopular == null
              ? const Center(child: CircularProgressIndicator())
              : Movielist(
                  list: moviesPopular!,
                  title: 'Popular Movies',
                  extra: '1',
                ),
          const SizedBox(
            height: 14,
          ),
          nowPlayingMovie == null
              ? const Center(child: CircularProgressIndicator())
              : Movielist(
                  list: nowPlayingMovie!,
                  title: 'Now Playing Movies',
                  extra: '',
                ),
        ],
      ),
    );
  }
}
