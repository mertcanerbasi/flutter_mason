import '../encrypt/aes_encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage(this._storage);
  final SharedPreferences _storage;
  T? read<T>(String key) {
    String? readData = _storage.getString(AesEncrypt.encrypt(key));
    if (readData != null) {
      String data = AesEncrypt.decrypt(readData);
      switch (T) {
        case const (int):
          return int.parse(data) as T;
        case const (double):
          return double.parse(data) as T;
        case const (num):
          return num.parse(data) as T;
        case const (bool):
          return (data == 'true') as T;
        case const (String):
          return data as T;
        default:
          throw Exception('Not yet implemented $key');
      }
    }
    return null;
  }

  Future<bool> write(String key, dynamic value) => value == null
      ? _storage.remove(AesEncrypt.encrypt(key))
      : _storage.setString(
          AesEncrypt.encrypt(key), AesEncrypt.encrypt(value.toString()));
}
