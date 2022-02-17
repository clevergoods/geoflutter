import '../../../data/common/routes/remote_routes.dart';
import '../../../utils/common/repositories/dio_request_utils.dart';

class NetAuthentictionService {
  DioRequestUtils dioService = DioRequestUtils.instance;

  Future<Map<String, dynamic>> loginWithToken(Map<String, dynamic> json) async {
    return await dioService.jsonRequest(json, RemoteRoutes.loginWithTokenUrl);
  }

  Future<Map<String, dynamic>> logout(Map<String, dynamic> json) async {
    return await dioService.jsonRequest(json, RemoteRoutes.logoutUrl);
  }

  Future<Map<String, dynamic>> isLogged() async {
    var json = <String, dynamic>{};
    return await dioService.jsonRequest(json, RemoteRoutes.isLoginUrl);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> json) async {
    return await dioService.jsonRequest(json, RemoteRoutes.loginUrl);
  }
}
