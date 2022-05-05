import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';
import 'package:movie_db/pages/detail_page.dart';

class Movielist extends StatefulWidget {
  List<Movie> list;
  String extra;
  final String title;
  Movielist(
      {Key? key, required this.list, required this.title, required this.extra})
      : super(key: key);

  @override
  State<Movielist> createState() => _MovielistState();
}

class _MovielistState extends State<Movielist> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                Movie m = widget.list[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => DetailPage(
                        movie: m,
                        extra: widget.extra,
                      ),
                    );
                  },
                  child: Hero(
                    tag: '${m.id}${widget.extra}',
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Image.network(
                              API.imageURL + m.posterPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              m.title,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
