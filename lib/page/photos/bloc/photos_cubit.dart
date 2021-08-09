import 'package:bloc/bloc.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/color.dart';
import 'package:pix/data/model/image_type.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/data/model/orientation.dart';
import 'package:pix/data/pixus_client.dart';
import 'package:pix/page/photos/bloc/photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final PixusClient _client;
  int _page = 1;
  ImageType imageType = ImageType.all;
  Order order = Order.popular;
  C? color;
  Orientation orientation = Orientation.all;
  Category? category;
  String query = "";

  int get page {
    return _page;
  }

  PhotosCubit(this._client) : super(PhotosInitial());

  void loadData() async {
    try {
      emit(PhotosLoading());
      var response = await _client.photos(
          page: _page,
          color: color,
          query: query,
          category: category,
          imageType: imageType,
          order: order,
          orientation: orientation);
      if (response.list.isNotEmpty) {
        _page += 1;
        emit(PhotosSuccess(response.list));
      } else {
        emit(PhotosEmpty());
      }
    } catch (error) {
      emit(PhotosError());
    }
  }

  void clearFilter() {
    _page = 1;
    emit(PhotosRefresh());

    this.imageType = ImageType.all;
    this.color = null;
    this.query = "";
    this.orientation = Orientation.all;
    this.category = null;
    this.order = Order.popular;
    loadData();
  }

  void refresh(
      {String query = "",
      ImageType imageType = ImageType.all,
      Order order = Order.popular,
      C? color,
      Orientation orientation = Orientation.all,
      Category? category}) {
    emit(PhotosRefresh());
    _page = 1;
    this.imageType = imageType;
    this.color = color;
    this.query = query;
    this.orientation = orientation;
    this.category = category;
    this.order = order;
    loadData();
  }
}
