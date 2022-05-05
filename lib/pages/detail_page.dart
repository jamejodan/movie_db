import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/components/movie_list.dart';
import 'package:movie_db/controller/detail_controller.dart';
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
  final DetailController _detailController = Get.put(DetailController());

  loadData() {
    _detailController.loadCastList(widget.movie.id);
    _detailController.loadRecommendList(widget.movie.id);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Detail Page'),
            ),
            body: SingleChildScrollView(
              child: Obx(() {
                return Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              API.imageURL + widget.movie.backdropPath),
                          fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  Positioned(top: 0, left: 0, child: detailHeader()),
                ]);
              }),
            )));
  }

  Widget detailHeader() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 130,
                    height: 180,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Hero(
                      tag: '${widget.movie.id}${widget.extra}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            API.imageURL + widget.movie.posterPath),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Rating : 10/${widget.movie.voteAverage}',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Total vote : ${widget.movie.voteCount}',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Popularity : ${widget.movie.popularity}',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Overview',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.movie.overview,
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Casts',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            _detailController.castList.isNotEmpty
                ? castListWidget()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            SizedBox(
              height: 20,
            ),
            _detailController.recommendationList.isNotEmpty
                ? Movielist(
                    title: 'Recommendations',
                    list: _detailController.recommendationList,
                    extra: '',
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget castListWidget() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Obx(() {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _detailController.castList.length,
              itemBuilder: (context, index) {
                var cast = _detailController.castList[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            API.imageURL + cast.profilePath!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cast.originalName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('as ${cast.name}',
                              style: TextStyle(color: Colors.white))
                        ],
                      )
                    ],
                  ),
                );
              });
        }));
  }
}
