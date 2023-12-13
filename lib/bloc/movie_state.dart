part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {} //загрузка

class MovieSucces extends MovieState {
  //успех

  final MovieListModel model;
  MovieSucces({required this.model});
}

class MovieError extends MovieState {
  final String errorText;
  MovieError({required this.errorText});
}
