import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/data/pixus_client.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final PixusClient _client;

  VideosCubit(this._client) : super(VideosInitial());

  void loadData(int page) async {
    try {
      emit(VideosLoading());
      var response = await _client.videos(page: page);
      if (response.list.isNotEmpty) {
        emit(VideosSuccess(response.list));
      } else {
        emit(VideosEmpty());
      }
    } catch (error) {
      emit(VideosError());
    }
  }
}
