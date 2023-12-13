part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class SerchMevieEvent extends MovieEvent {
  final String name;
  SerchMevieEvent({required this.name});
}
