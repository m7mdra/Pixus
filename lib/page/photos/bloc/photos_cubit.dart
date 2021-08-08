import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/data/pixus_client.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final PixusClient _client;

  PhotosCubit(this._client) : super(PhotosInitial());

  void loadData(int page) async {
    try {
      emit(PhotosLoading());
      var response = await _client.photos(page: page);
      if (response.list.isNotEmpty) {
        emit(PhotosSuccess(response.list));
      } else {
        emit(PhotosEmpty());
      }
    } catch (error) {
      emit(PhotosError());
    }
  }
}
