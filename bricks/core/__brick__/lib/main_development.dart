import 'bootstrap.dart';
import './feature/page/app/app.dart';
import 'package:injectable/injectable.dart';

void main() async {
  bootstrap(() => const App(), Environment.dev);
}
