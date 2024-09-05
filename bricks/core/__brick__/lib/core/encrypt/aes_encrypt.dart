import 'package:encrypt/encrypt.dart';

class AesEncrypt {
  static final _key = Key.fromUtf8('xF9an94BvjDSRrb52aUCDytxE8BbRWwJ');
  static final _iv = IV.fromUtf8('myinitvector1234');

  static String encrypt(String plainText) {
    return Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'))
        .encrypt(plainText, iv: _iv)
        .base64;
  }

  static String decrypt(String encrypted) {
    final value = Encrypted.fromBase64(encrypted);
    return Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'))
        .decrypt(value, iv: _iv);
  }
}
