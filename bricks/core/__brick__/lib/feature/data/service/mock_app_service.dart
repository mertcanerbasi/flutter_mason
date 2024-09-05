import './app_service.dart';

class MockAppService implements AppService {
  MockAppService();

  @override
  Future<String> getAppVersion() async {
    return "1.0.0";
  }
}
