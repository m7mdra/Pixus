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
  ImageType imageType = ImageType.all;
  int _page = 1;
  Order order = Order.popular;
  C color = C.all;
  Orientation orientation = Orientation.all;
  Category category = Category.all;
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

      emit(PhotosSuccess(response.list));
      _page += 1;
    } catch (error) {
      emit(PhotosError());
    }
  }

  void clearFilter() {
    _page = 1;
    emit(PhotosRefresh());

    this.imageType = ImageType.all;
    this.color = C.all;
    this.query = "";
    this.orientation = Orientation.all;
    this.category = Category.all;
    this.order = Order.popular;
    loadData();
  }

  void refresh(
      {String query = "",
      ImageType imageType = ImageType.all,
      Order order = Order.popular,
      C color = C.all,
      Orientation orientation = Orientation.all,
      Category category = Category.all}) {
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
