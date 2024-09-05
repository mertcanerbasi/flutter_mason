import 'package:injectable/injectable.dart';
import './{{name.snakeCase()}}_repository.dart';

@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository {

  {{name.pascalCase()}}RepositoryImpl();
}