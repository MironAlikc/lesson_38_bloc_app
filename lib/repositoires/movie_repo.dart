import 'package:dio/dio.dart';

import '../models/movie_models.dart';

class MoviRepo {
  MoviRepo({required this.dio});
  final Dio dio;

  Future<MovieListModel> getData(String name) async {
    final respose =
        await dio.get('http://www.omdbapi.com/?apikey=9a32a1a8&s=$name');
    final reslut = MovieListModel.fromJson(respose.data);
    return reslut;
  }
}
