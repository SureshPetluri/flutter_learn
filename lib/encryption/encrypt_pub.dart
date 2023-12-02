import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;

void main() {
  final key = "Ma1sbhCI8Ag1IeB5";
  final plainText = "\$Test Encryption polytok#";
  String encrypted = encrypt(key, plainText);
  String decryptedText = decrypt(key, "7xuu2CKgV1kDtCsFGFHd4g2FBpEvqSAC+/KbEpLHS/h95j7QTBnxr5TMUbuJOx9+VXcAiTMg3f/jpydO/JtG5g==");
  print(encrypted);
  print(decryptedText);
}

String decrypt(String keyString, String encryptedData) {
  final key = enc.Key.fromUtf8(keyString);
  final encryptor =  enc.Encrypter(enc.AES(key, mode:  enc.AESMode.cbc,padding: null));
  final initVector =  enc.IV.fromUtf8(keyString.substring(0,16));
  return encryptor.decrypt64(encryptedData, iv: initVector).substring(16).replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F]'), '');
}

String encrypt(String keyString, String plainText) {
  final key = enc.Key.fromUtf8(keyString);
  final encryptor = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  final initVector = enc.IV.fromUtf8(keyString.substring(0,16));
  String encryptedData = encryptor.encrypt(_addPadding(keyString + jsonEncode(plainText)), iv: initVector).base64;
  return encryptedData;
}

String _addPadding(String plaintext) {
  const blockSize = 16; // AES block size is 16 bytes
  final padLength = blockSize - (plaintext.length % blockSize);
  final padding =
  String.fromCharCode(padLength).padRight(padLength, '\x00');
  return plaintext + padding;
}
