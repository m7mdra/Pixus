part of 'videos_cubit.dart';

@immutable
abstract class VideosState {}

class VideosInitial extends VideosState {}
class VideosLoading extends VideosState {}
class VideosEmpty extends VideosState {}
class VideosSuccess extends VideosState {
  final List<Video> list;

  VideosSuccess(this.list);

}
class VideosError extends VideosState {}


