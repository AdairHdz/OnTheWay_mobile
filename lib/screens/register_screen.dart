import 'dart:async';
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/registerRequestDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/stateDTO/stateDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';
import 'package:on_the_way_mobile/widgets/custom_dropdown_button.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  List<CustomInput> listOfStates = List.empty(growable: true);
  RegisterRequestDTO _registerRequestDTO = RegisterRequestDTO(
      names: "",
      lastName: "",
      emailAddress: "",
      password: "",
      stateId: "",
      userType: 0);

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _registerUser();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStates();
  }

  Future<void> _fetchStates() async {
    RestRequest request = RestRequest();
    try {
      var response = await request.getResource("/v1/states", false);
      if (response.statusCode == 200) {
        List<StateDTO> listOfStatesDTO = (json.decode(response.body) as List)
            .map((i) => StateDTO.fromJson(i))
            .toList();
        listOfStatesDTO.forEach((stateDTO) {
          setState(() {
            CustomInput customInput =
                CustomInput(child: stateDTO.name, value: stateDTO.id);
            listOfStates.add(customInput);
          });
        });
      }
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 404:
          exceptionMessage = "No se encontró al Estado solicitado.";
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

  Future<void> _registerUser() async {
    RestRequest request = RestRequest();
    try {
      var response = await request.postResource(
          "/v1/register", _registerRequestDTO, false);
      if (response.statusCode == 201) {
        showNotification(context, "Usuario registrado",
            "El usuario se ha registrado correctamente", "Aceptar");
      }
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
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: (deviceHeight + 50),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 30),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/logo-black.png",
                            ),
                            width: 150,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Registro",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _form,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Nombres"),
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"[A-z ]{1,50}",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Por favor inserte solo letras y espacios en blanco";
                                  },
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: value,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Apellidos"),
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"[A-z ]{1,50}",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Por favor inserte solo letras y espacios en blanco";
                                  },
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: value,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Correo"),
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Dirección de correo inválida";
                                  },
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress: value,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: value,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                  validator: (value) {
                                    String password = value.trim();
                                    if (password.length >= 8 &&
                                        password.length <= 50) {
                                      return null;
                                    }
                                    showNotification(
                                        context,
                                        "Contaseña insegura",
                                        "Por favor ingrese una contraseña con al menos 8 caracteres",
                                        "Aceptar");
                                    return "Contraseña inválida";
                                  },
                                  obscureText: true,
                                ),
                                DropdownButtonFormField(
                                  hint: Text("Estado"),
                                  items: [
                                    if (listOfStates != null &&
                                        listOfStates.isNotEmpty)
                                      ...listOfStates.map(
                                        (option) {
                                          return DropdownMenuItem(
                                            child: Text(option.child),
                                            value: option.value,
                                          );
                                        },
                                      )
                                  ],
                                  validator: (value) {
                                    if (value == null) {
                                      return "Seleccione un estado";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _registerRequestDTO = RegisterRequestDTO(
                                          names: _registerRequestDTO.names,
                                          lastName:
                                              _registerRequestDTO.lastName,
                                          emailAddress:
                                              _registerRequestDTO.emailAddress,
                                          password:
                                              _registerRequestDTO.password,
                                          userType:
                                              _registerRequestDTO.userType,
                                          stateId: value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            hint: Text("Tipo de usuario"),
                            value: _registerRequestDTO.userType,
                            items: [
                              DropdownMenuItem(
                                child: Text("Proveedor de servicio"),
                                value: 0,
                              ),
                              DropdownMenuItem(
                                child: Text("Solicitante de servicio"),
                                value: 1,
                              )
                            ],
                            validator: (value) {
                              if (value == null) {
                                return "Seleccione un tipo de usuario";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _registerRequestDTO = RegisterRequestDTO(
                                    names: _registerRequestDTO.names,
                                    lastName: _registerRequestDTO.lastName,
                                    emailAddress:
                                        _registerRequestDTO.emailAddress,
                                    password: _registerRequestDTO.password,
                                    userType: value,
                                    stateId: _registerRequestDTO.stateId);
                              });
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AccentButton(_saveForm, "Iniciar sesión"),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                top: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
