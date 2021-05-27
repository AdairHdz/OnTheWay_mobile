import 'package:http/http.dart' as http;
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'dart:convert';
import 'dart:async';

import 'requestable.dart';

class RestRequest implements Requestable {
  //static final String baseURL = "192.168.100.41:8080";
  static final String baseURL = "192.168.100.41:8080";
  @override
  Future<http.Response> getResource(String endpoint, bool includeToken,
      [Map<String, String> requestHeaders]) async {
    Session mySession = Session();
    Map<String, String> defaultRequestHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    if (includeToken) {
      if (requestHeaders == null) {
        defaultRequestHeaders["Authorization"] = "Bearer ${mySession.token}";
      } else {
        requestHeaders["Authorization"] = "Bearer ${mySession.token}";
      }
    }
    final response = await http
        .get(
      Uri.http(baseURL, endpoint),
      headers: requestHeaders == null ? defaultRequestHeaders : requestHeaders,
    )
        .timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw TimeoutException("Server took too long to respond");
      },
    );

    return response;
  }

  @override
  Future<http.Response> postResource(
      String endpoint, Object payload, bool includeToken,
      [Map<String, String> requestHeaders]) async {
    Session mySession = Session();
    Map<String, String> defaultRequestHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    if (includeToken) {
      if (requestHeaders == null) {
        defaultRequestHeaders["Authorization"] = "Bearer ${mySession.token}";
      } else {
        requestHeaders["Authorization"] = "Bearer ${mySession.token}";
      }
    }

    final response = await http
        .post(
      Uri.http(baseURL, endpoint),
      headers: requestHeaders == null ? defaultRequestHeaders : requestHeaders,
      body: jsonEncode(payload),
    )
        .timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw TimeoutException(
            "El servidor ha tardado demasiado en responder. Por favor, intente más tarde");
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      String errorMessage;
      switch (response.statusCode) {
        case 400:
          errorMessage = "La información enviada no tiene un formato válido.";
          break;
        case 409:
          errorMessage =
              "Ha ocurrido un error mientras intentábamos registrar su cuenta. Por favor, intente más tarde";
          break;
        case 500:
          errorMessage =
              "Ha ocurrido un error mientras se procesaba su solicitud. Por favor, intente más tarde.";
          break;
        default:
          print(response.statusCode);
          errorMessage =
              "Ha ocurrido un error desconocido. Por favor, intente más tarde";
          break;
      }
      throw NetworkRequestException(errorMessage, response.statusCode);
    }
    return response;
  }

  Future<http.Response> deleteResource(String endpoint, bool includeToken,
      [Map<String, String> requestHeaders]) async {
    Session mySession = Session();
    Map<String, String> defaultRequestHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    if (includeToken) {
      if (requestHeaders == null) {
        defaultRequestHeaders["Authorization"] = "Bearer ${mySession.token}";
      } else {
        requestHeaders["Authorization"] = "Bearer ${mySession.token}";
      }
    }
    final response = await http
        .delete(
      Uri.http(baseURL, endpoint),
      headers: requestHeaders == null ? defaultRequestHeaders : requestHeaders,
    )
        .timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw TimeoutException("Server took too long to respond");
      },
    );

    if (response.statusCode != 204) {
      String errorMessage;
      switch (response.statusCode) {
        case 400:
          errorMessage = "La información enviada no tiene un formato válido.";
          break;
        case 409:
          errorMessage =
              "Ha ocurrido un error mientras intentábamos registrar su cuenta. Por favor, intente más tarde";
          break;
        case 500:
          errorMessage =
              "Ha ocurrido un error mientras se procesaba su solicitud. Por favor, intente más tarde.";
          break;
        default:
          print(response.statusCode);
          errorMessage =
              "Ha ocurrido un error desconocido. Por favor, intente más tarde";
          break;
      }
      throw NetworkRequestException(errorMessage, response.statusCode);
    }
    return response;
  }
}
