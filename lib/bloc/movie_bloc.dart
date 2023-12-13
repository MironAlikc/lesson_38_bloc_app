import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_38/models/movie_models.dart';
import 'package:lesson_38/repositoires/movie_repo.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.repo}) : super(MovieInitial()) {
    on<SerchMevieEvent>(
      (event, emit) async {
        emit(MovieLoading());
        try {
          final model = await repo.getData(event.name);
          emit(
            MovieSucces(model: model),
          );
        } catch (e) {
          emit(
            MovieError(
              errorText: e.toString(),
            ),
          );
        }
      },
    );
  }
  final MoviRepo repo;
}
