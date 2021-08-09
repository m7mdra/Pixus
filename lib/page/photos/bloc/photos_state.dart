

import 'package:flutter/foundation.dart';
import 'package:pix/data/model/photo_response.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}
class PhotosLoading extends PhotosState {}
class PhotosEmpty extends PhotosState {}
class PhotosRefresh extends PhotosState{}
class PhotosSuccess extends PhotosState {
  final List<Photo> list;

  PhotosSuccess(this.list);

}
class PhotosError extends PhotosState {}


