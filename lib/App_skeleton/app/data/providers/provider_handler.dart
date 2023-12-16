import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart' as enc;

import '../../utils/constants.dart';
import '../../utils/debug_utils.dart';
import '../repository/auth_repository.dart';

enum RequestMethod {
  get,
  post,
  patch,
  put,
  delete,
  //option
}

///  Provider used to interact with backend API
class ProvidersHandler extends GetConnect {
  Future<Map<String, dynamic>> requestApi(RequestMethod method, String path,
      {final Map<String, dynamic>? params,
        final Map<String,dynamic>? body,
        final Map<String, String>? headers,
        final boolAuthToken = false}) {

    final String apiBase = base_url + path;

    return _getAPIResponse(method, apiBase, headers ?? {},
        params: params, body: body ?? {}, boolAuthToken: boolAuthToken);
  }

  Future<Map<String, dynamic>> _getAPIResponse(
      RequestMethod method,
      final String url,
      final Map<String, String> headers, {
        final Map<String, dynamic>? params,
         final Map<String, dynamic>? body,
        final bool? boolAuthToken,
      }) async {
    String secretKey = "6ut7MoqRBcgiyR4K";
    final keyEnc = enc.Key.fromUtf8(secretKey);
    final encryptor = enc.Encrypter(enc.AES(keyEnc, mode: enc.AESMode.cbc, padding: null));
    enc.IV iv = enc.IV.fromSecureRandom(16);
    DebugUtils.printAsdf("IV: ${iv.base64}");

    Map<String, dynamic> paramsBody = {}..addAll(params ?? {})..addAll(
        body ?? {});
    String _addPadding(String plaintext) {
      const blockSize = 16; // AES block size is 16 bytes
      final padLength = blockSize - (plaintext.length % blockSize);
      final padding =
      String.fromCharCode(padLength).padRight(padLength, '\x00');
      return plaintext + padding;
    }

    Map<String, dynamic>? encParamBody;
    if (paramsBody.isNotEmpty) {
      try {
        var encBody = encryptor
            .encrypt(_addPadding(secretKey + jsonEncode(paramsBody)), iv: iv)
            .base64;
        encBody.replaceAll(RegExp(r'(\r\n|\n|\r)'), "");
        encParamBody = {"body": encBody};

        DebugUtils.printAsdf("Encrypted params and body: $encParamBody");
        DebugUtils.printAsdf(
            "Decrypted req body: ${encryptor.decrypt64(encBody, iv: iv)
                .substring(16)}");
      } catch (e) {
        DebugUtils.printError("Encryption failed: $e");
      }
    }


    Response response;
    Map<String, dynamic> respBody = {};

    Map<String, String> headers = boolAuthToken == true
        ? {
      CONTENT_TYPE: APPLICATION_URL,
      AUTHORIZATION:
      OAUTH_BEARER + AuthRepository.getAuthToken()
    }
        : {};

    try {
        switch (method) {
          case RequestMethod.get:
            response = await get(url,
                query: params, contentType: APPLICATION_JSON, headers: headers);
            respBody = response.body ?? {};
            print("get url $url");
            break;
          case RequestMethod.post:
            response =
            await post(url, body ?? {}, query: params, headers: headers);
            respBody = response.body ?? {};
            print("post url $url");
            print("post body $body");
            break;
          case RequestMethod.put:
            response =
            await put(url, body ?? {}, query: params, headers: headers);
            respBody = response.body ?? {};
            print("put url $url");
            print("put body $body");
            break;
          case RequestMethod.patch:
            response =
            await patch(url, body ?? {}, query: params, headers: headers);
            respBody = response.body ?? {};
            print("patch url $url");
            print("patch body $body");
            break;
          case RequestMethod.delete:
            response = await delete(url, query: params, headers: headers);
            respBody = response.body ?? {};
            print("delete url $url");
            print("delete body $body");
            break;
          default:
            throw Exception('Request Method: $method not implemented');
        }
      } catch (e) {
      respBody = {};
    }
    try {
      var decResp = encryptor.decrypt64(
          respBody[DATA]
              .toString()
              .replaceAll(RegExp(r'(\r\n|\n|\r)'), ""),
          iv: iv);
      decResp = decResp.substring(
          decResp.indexOf("{\""), decResp.lastIndexOf("}") + 1);
      DebugUtils.printAsdf("decResp1: $decResp");
      if (kIsWeb) {
        DebugUtils.printAsdf(
            "Decrypted resp body for /${url
                .split("/")
                .last}: ${jsonDecode(decResp)}");
      } else {
        DebugUtils.printLog(
            "Decrypted resp body for /${url
                .split("/")
                .last}: ${jsonDecode(decResp)}");
      }
      respBody = jsonDecode(decResp);
    } catch (e) {
      DebugUtils.printError("Decryption failed: $e");
    }
    return respBody;
  }
}