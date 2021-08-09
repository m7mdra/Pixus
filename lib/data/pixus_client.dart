import 'package:dio/dio.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/image_type.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/data/model/orientation.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/data/model/video_response.dart';

import 'model/color.dart';

const _KPerPage = 20;

class PixusClient {
  final Dio client;
  PixusClient({required this.client});

  Future<PhotoResponse> photos({required int page,
    String query = "",
    ImageType imageType = ImageType.all,
    Order order = Order.popular,
    C? color,
    Orientation orientation = Orientation.all,
    Category? category}) async {
    try {
      var queryParameters = <String, dynamic>{};
      if (query.isNotEmpty) {
        queryParameters['q'] = query;
      }
      queryParameters['orientation'] = orientation.name.toLowerCase();
      if (color != null) {
        queryParameters['colors'] = color.name.toLowerCase();
      }
      if (category != null) {
        queryParameters['category'] = category.name.toLowerCase();
      }
      queryParameters['order'] = order.name.toLowerCase();
      queryParameters['safesearch'] = true;
      queryParameters['image_type'] = imageType.name.toLowerCase();
      queryParameters['per_page'] = _KPerPage;
      queryParameters['page'] = page;

      var response = await client.get("", queryParameters: queryParameters);
      return PhotoResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }

  Future<VideoResponse> videos({required int page,
    String query = "",
    Order order = Order.popular}) async {
    try {
      var queryParameters = <String, dynamic>{};
      if (query.isNotEmpty) {
        queryParameters['q'] = query;
      }
      queryParameters['order'] = order.name.toLowerCase();
      queryParameters['safesearch'] = true;
      queryParameters['per_page'] = _KPerPage;
      queryParameters['page'] = page;

      var response =
      await client.get("videos/", queryParameters: queryParameters);
      return VideoResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }
}
