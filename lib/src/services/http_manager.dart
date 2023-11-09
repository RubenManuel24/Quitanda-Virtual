import 'package:dio/dio.dart';

abstract class HttMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest(
      {required urlEndPonit, required method, Map? headers, Map? body}) async {
    //Headers da RequisiçãO
    final defaultHeader = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(urlEndPonit,
          options: Options(
            method: method,
            headers: defaultHeader,
          ),
          data: body);

      //Retorno dos resultados do BackEnd
      return response.data;
    } on DioException catch (error) {
      //Retorno do erro da Dio request
      return error.response?.data;
    } catch (error) {
      //Retorno de Map vazio para erro generalizado
      return {};
    }
  }
}
