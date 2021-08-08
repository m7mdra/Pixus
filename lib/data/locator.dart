import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pix/data/pixus_client.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static Future<void> init() async {
    var options = BaseOptions(
        baseUrl: "https://pixabay.com/api/",
        queryParameters: {'key': '13624680-de8a8b9720a4e9945c0f778b0'});
    var httpClient = Dio(options);
    var pixusClient = PixusClient(client: httpClient);
    getIt.registerSingleton(httpClient);
    getIt.registerSingleton(pixusClient);
  }
}
