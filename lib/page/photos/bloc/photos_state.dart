part of 'photos_cubit.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}
class PhotosLoading extends PhotosState {}
class PhotosEmpty extends PhotosState {}
class PhotosSuccess extends PhotosState {
  final List<Photo> list;

  PhotosSuccess(this.list);

}
class PhotosError extends PhotosState {}


