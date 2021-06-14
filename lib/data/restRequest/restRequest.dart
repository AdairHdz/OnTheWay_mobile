import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:on_the_way_mobile/data/restRequest/requestable.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'dart:convert';
import 'dart:async';
import 'package:path/path.dart';

class RestRequest implements Requestable {
  //static final String baseURL = "192.168.100.41:8080";
  static final String baseURL = "192.168.100.173:8080";
  @override
  Future<http.Response> getResource(String endpoint, bool includeToken,
      [Map<String, String> requestHeaders,
      Map<String, String> queryParameters]) async {
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
      Uri.http(baseURL, endpoint, queryParameters),
      headers: requestHeaders == null ? defaultRequestHeaders : requestHeaders,
    )
        .timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw TimeoutException("Server took too long to respond");
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      String errorMessage;
      switch (response.statusCode) {
        case 400:
          errorMessage = "La información enviada no tiene un formato válido.";
          break;
        case 404:
          errorMessage = "No se encontró el recurso solicitado.";
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
          errorMessage =
              "Ha ocurrido un error desconocido. Por favor, intente más tarde";
          break;
      }
      throw NetworkRequestException(errorMessage, response.statusCode);
    }
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

  @override
  Future<http.StreamedResponse> putImageResource(
      String endpoint, String filePath) async {
    Session mySession = Session();
    File imageFile = File(filePath);

    Map<String, String> requestHeaders = {
      "Authorization": "Bearer ${mySession.token}"
    };
    var stream = new http.ByteStream((imageFile.openRead().cast()));
    var length = await imageFile.length();

    var uri = Uri.http(baseURL, endpoint);

    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    request.headers.addAll(requestHeaders);
    request.files.add(multipartFile);
    var response = await request.send();
    return response;
  }

  @override
  Future<http.Response> patchResource(
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
        .patch(
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

  @override
  Future<http.Response> putResource(
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
        .put(
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
          errorMessage =
              "Ha ocurrido un error desconocido. Por favor, intente más tarde";
          break;
      }
      throw NetworkRequestException(errorMessage, response.statusCode);
    }
    return response;
  }
}
