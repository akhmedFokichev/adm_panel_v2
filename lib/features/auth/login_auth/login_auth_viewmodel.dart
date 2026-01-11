import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/services/alert_service.dart';
import 'package:stacked/stacked.dart';

import '../../../router/navigation_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/location_service.dart';

class LoginAuthViewmodel extends BaseViewModel {
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  bool isOnLoginButton = false;

  final _navigationService = GetIt.instance<NavigationService>();
  final _alertService = GetIt.instance<AlertService>();
  final _authService = GetIt.instance<AuthService>();

  initialize() {
    print("LoginAuthViewmodel>initialize");
    binds();
  }

  @override
  void dispose() {
    loginTextController.dispose(); // ВАЖНО: освобождаем ресурсы
    passwordTextController.dispose(); // ВАЖНО: освобождаем ресурсы
    super.dispose();
  }

  void binds() {
    // Подписываемся на изменения
    loginTextController.addListener(_onLoginTextChanged);
    passwordTextController.addListener(_onPasswordTextChanged);
  }

  Future<void> tapLogin() async {
    String login = loginTextController.text;
    String password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      return;
    }

    final result  =  await _authService.loginWithPassword(login, password);

    // print("result>data>" + result.data.toString() + " statusCode>" + result.statusCode.toString());
    // print("result>message>" + result.message.toString()  + " statusCode>" + result.statusCode.toString());

    //_alertService.showError(message: "message");
  }

  void _onLoginTextChanged() {
    validateInputs();
  }

  void _onPasswordTextChanged() {
    validateInputs();
  }

  void validateInputs() {
    String login = loginTextController.text;
    String password = passwordTextController.text;

    if(login.isNotEmpty && password.isNotEmpty) {
      isOnLoginButton = true;
    } else {
      isOnLoginButton = false;
    }

    notifyListeners();
  }

  // Установить значение программно
  void setText(String text) {
    loginTextController.text = text;
  }
}