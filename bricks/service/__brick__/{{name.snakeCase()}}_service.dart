import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part '{{name.snakeCase()}}_service.g.dart';
/*
  @Environment(Environment.prod)
  @lazySingleton
  {{name.pascalCase()}}Service get {{name.snakeCase()}}Service => {{name.pascalCase()}}Service(injectRetrofitAPI);

  @Environment(Environment.dev)
  @lazySingleton
  {{name.pascalCase()}}Service get {{name.snakeCase()}}ServiceMock => Mock{{name.pascalCase()}}Service();

*/
@RestApi()
abstract class {{name.pascalCase()}}Service {
  factory {{name.pascalCase()}}Service(Dio dio, {String baseUrl}) = _{{name.pascalCase()}}Service;
}
