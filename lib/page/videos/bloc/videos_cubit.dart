import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/data/model/video_type.dart';
import 'package:pix/data/pixus_client.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final PixusClient _client;
  int _page = 1;
  Order _order = Order.popular;
  Category _category = Category.all;
  VideoType _videoType = VideoType.all;

  VideosCubit(this._client) : super(VideosInitial());

  int get page {
    return _page;
  }

  void loadData() async {
    try {
      emit(VideosLoading());
      var response = await _client.videos(
          page: page,
          videoType: _videoType,
          category: _category,
          order: _order);
      if (response.list.isNotEmpty) {
        _page += 1;
        emit(VideosSuccess(response.list));
      } else {
        emit(VideosEmpty());
      }
    } catch (error) {
      emit(VideosError());
    }
  }

  void clearFilter() {
    _page = 1;
    emit(VideosRefresh());

    this._videoType = VideoType.all;
    this._category = Category.all;
    this._order = Order.popular;
    loadData();
  }

  void refresh(
      {Order order = Order.popular,
      VideoType videoType = VideoType.all,
      Category category = Category.all}) {
    emit(VideosRefresh());
    _page = 1;

    this._videoType = videoType;
    this._category = category;
    this._order = order;
    loadData();
  }
}
