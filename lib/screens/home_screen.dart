import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/reviewPaginationDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceProviderDTO/serviceProviderDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/navigation_button_bar.dart';
import 'package:on_the_way_mobile/widgets/price_rate.dart';
import 'package:on_the_way_mobile/widgets/profile_info.dart';
import 'package:on_the_way_mobile/widgets/reviews_list.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 1;
  int _pageSize = 5;
  int _totalPages = 1;
  int _totalRows = 0;
  ReviewPaginationDTO _reviewPaginationDTO = ReviewPaginationDTO();
  ServiceProviderDTO _serviceProviderDTO = ServiceProviderDTO(
      names: "...",
      lastName: "...",
      emailAddress: "...",
      averageScore: 0,
      priceRates: new List.empty(growable: true),
      profileImage: "");

  void navigateToPriceRateRegistry(BuildContext context) {
    Navigator.of(context).pushNamed("/price-rate");
  }

  Future<void> _getServiceProviderData() async {
    RestRequest request = RestRequest();
    try {
      var response =
          await request.getResource("/v1.0.0/providers/${Session().id}", true);
      Map<String, dynamic> serviceProviderMap = jsonDecode(response.body);
      setState(() {
        _serviceProviderDTO = ServiceProviderDTO.fromJson(serviceProviderMap);
        Session session = Session();
        session.profilePicture = _serviceProviderDTO.profileImage;
      });
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 400:
          exceptionMessage =
              "Por favor asegúrese de haber introducido información válida e intente nuevamente.";
          break;
        case 401:
          exceptionMessage = "Lo sentimos; su sesión ha expirado.";
          break;
        case 404:
          exceptionMessage =
              "Tuvimos un problema al recuperar sus datos. Por favor, intente más tarde.";
          break;
        case 409:
          exceptionMessage =
              "Lo sentimos; ha ocurrido un error al intentar procesar su solicitud.";
          break;
        default:
          exceptionMessage =
              "Ha ocurrido un error desconocido. Por favor, intente m{as tarde.}.";
          break;
      }
      showNotification(context, "Error", exceptionMessage, "Aceptar");
    }
  }

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _pageSize = 5;
    _getServiceProviderData();
    _getReviews();
  }

  void _navigateToNextPage() {
    setState(() {
      _currentPage++;
      _getReviews();
    });
  }

  void _navigateToPreviousPage() {
    setState(() {
      _currentPage--;
      _getReviews();
    });
  }

  void _navigateToFirstPage() {
    setState(() {
      _currentPage = 1;
      _getReviews();
    });
  }

  void _navigateToLastPage() {
    setState(() {
      _currentPage = _totalPages;
      _getReviews();
    });
  }

  Future<void> _getReviews() async {
    RestRequest request = new RestRequest();
    Map<String, String> queryParameters = {
      "page": _currentPage.toString(),
      "pagesize": _pageSize.toString()
    };
    try {
      var response = await request.getResource(
          "/v1.0.0/providers/${Session().id}/reviews",
          true,
          null,
          queryParameters);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      setState(() {
        _reviewPaginationDTO = ReviewPaginationDTO.fromJson(responseBody);
        _currentPage = _reviewPaginationDTO.page;
        _totalPages = (_reviewPaginationDTO.total / _pageSize).ceil();
        _totalRows = _reviewPaginationDTO.total;
      });
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 400:
          exceptionMessage =
              "Por favor asegúrese de haber introducido información válida e intente nuevamente.";
          showNotification(context, "Error", exceptionMessage, "Aceptar");
          break;
        case 401:
          exceptionMessage = "Lo sentimos; su sesión ha expirado.";
          showNotification(context, "Error", exceptionMessage, "Aceptar");
          break;
        case 404:
          exceptionMessage = "";
          break;
        case 409:
          exceptionMessage =
              "Lo sentimos; ha ocurrido un error al intentar procesar su solicitud.";
          showNotification(context, "Error", exceptionMessage, "Aceptar");
          break;
        default:
          exceptionMessage =
              "Ha ocurrido un error desconocido. Por favor, intente m{as tarde.}.";
          showNotification(context, "Error", exceptionMessage, "Aceptar");
          break;
      }
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          mini: true,
          onPressed: () => navigateToPriceRateRegistry(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileInfo(
                serviceProviderName: _serviceProviderDTO.names +
                    " " +
                    _serviceProviderDTO.lastName,
                averageScore: _serviceProviderDTO.averageScore,
                profileImage: _serviceProviderDTO.profileImage,
              ),
              Container(
                width: deviceWidth * 0.95,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        width: deviceWidth,
                        child: Text("Tarifas",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left),
                      ),
                      PriceRate(_serviceProviderDTO.priceRates)
                    ],
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.95,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        width: deviceWidth,
                        child: Text("Reseñas",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left),
                      ),
                      ReviewsList(_reviewPaginationDTO.data),
                      NavigationButtonBar(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                        totalRows: _totalRows,
                        firstPageHandler:
                            _currentPage <= 1 ? null : _navigateToFirstPage,
                        previousPageHandler:
                            _currentPage <= 1 ? null : _navigateToPreviousPage,
                        nextPageHandler: _currentPage >= _totalPages
                            ? null
                            : _navigateToNextPage,
                        lastPageHandler: _currentPage >= _totalPages
                            ? null
                            : _navigateToLastPage,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
