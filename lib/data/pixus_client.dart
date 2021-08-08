import 'package:dio/dio.dart';
import 'package:pix/data/model/image_type.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/data/model/video_response.dart';
const _KPerPage = 10;

class PixusClient {
  final Dio client;

  PixusClient({required this.client});

  Future<PhotoResponse> photos(
      {required int page,
      String query = "",
      ImageType imageType = ImageType.all,
      Order order = Order.popular}) async {
    try {
      var queryParameters = <String, dynamic>{};
      if (query.isNotEmpty) {
        queryParameters['q'] = query;
      }
      queryParameters['order'] = order.name;
      queryParameters['safesearch'] = true;
      queryParameters['image_type'] = imageType.name;
      queryParameters['per_page'] = _KPerPage;
      queryParameters['page'] = page;

      var response = await client.get("", queryParameters: queryParameters);
      return PhotoResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }
  Future<VideoResponse> videos( {required int page,
    String query = "",
    Order order = Order.popular}) async {
    try {
      var queryParameters = <String, dynamic>{};
      if (query.isNotEmpty) {
        queryParameters['q'] = query;
      }
      queryParameters['order'] = order.name;
      queryParameters['safesearch'] = true;
      queryParameters['per_page'] = _KPerPage;
      queryParameters['page'] = page;

      var response = await client.get("videos/", queryParameters: queryParameters);
      return VideoResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }

  }
}
