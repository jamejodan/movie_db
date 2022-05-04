import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_db/components/movie_list.dart';
import 'package:movie_db/components/search_list.dart';
import 'package:movie_db/models/cast.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';

class DetailPage extends StatefulWidget {
  Movie movie;
  String extra;
  DetailPage({Key? key, required this.movie, required this.extra})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;
  List<Movie>? recomMovies;

  load() {
    api.getRecomd(widget.movie.id).then((value) {
      setState(() {
        recomMovies = value;
      });
    });
  }

  @override
  void initState() {
    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });
    load();
    super.initState();
  }

  _castInformation() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Cast c = casts![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                c.profilePath == null
                    ? Container()
                    : Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(API.imageURL + c.profilePath!),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(c.originalName),
              ],
            ),
          );
        },
      );

  _movieInformation() => Column(
        children: [
          Hero(
            tag: "${widget.movie.id}${widget.extra}",
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.6,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(API.imageURL + widget.movie.posterPath),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.movie.title)),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _movieInformation(),
                  const SizedBox(
                    height: 12,
                  ),
                  casts == null
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          //color: Colors.greenAccent,
                          width: double.infinity,
                          height: 300,
                          child: _castInformation(),
                        ),
                  recomMovies == null
                      ? const CircularProgressIndicator()
                      : Movielist(
                          list: recomMovies!,
                          title: 'Recommendations',
                          extra: ''),
                ],
              ),
            )
          ],
        ));
  }
}
