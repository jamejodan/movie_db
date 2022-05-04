// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_db/components/search_list.dart';
import 'package:movie_db/models/movie.dart';
import 'package:movie_db/network/api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchAPI = API();
  List<Movie>? moviesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            searchAPI.getSearch(val).then((value) {
              setState(() {
                moviesList = value;
              });
            });
          },
          textInputAction: TextInputAction.search,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              borderSide: BorderSide(color: Colors.white),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            //fillColor: Colors.white,
            label: Text(
              'Enter Movies Name..',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: moviesList == null
          ? Text('enter search text')
          : MovieList(list: moviesList!),
    );
  }
}
