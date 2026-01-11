import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/router/navigation_service.dart';

class PhoneInputViewModel extends BaseViewModel {
  final _navigationService = GetIt.instance<NavigationService>();

  String _phoneNumber = '';
  bool _isPhoneValid = false;

  String get phoneNumber => _phoneNumber;
  bool get isPhoneValid => _isPhoneValid;

  void updatePhoneNumber(String phone) {
    _phoneNumber = phone;
    _isPhoneValid = _validatePhone(phone);
    notifyListeners();
  }

  bool _validatePhone(String phone) {
    // Простая валидация: минимум 10 цифр
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly.length >= 10;
  }

  String get formattedPhone {
    final digitsOnly = _phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length <= 3) return '+7 ($digitsOnly';
    if (digitsOnly.length <= 6) {
      return '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
    }
    if (digitsOnly.length <= 8) {
      return '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    }
    // Для номеров длиной 9-10 цифр
    if (digitsOnly.length <= 10) {
      final part1 = digitsOnly.substring(0, 3);
      final part2 = digitsOnly.substring(3, 6);
      final part3 = digitsOnly.length >= 8
          ? digitsOnly.substring(6, 8)
          : digitsOnly.substring(6);
      final part4 = digitsOnly.length >= 10 ? digitsOnly.substring(8, 10) : '';
      return '+7 ($part1) $part2-$part3${part4.isNotEmpty ? '-$part4' : ''}';
    }
    // Если номер длиннее 10 цифр, обрезаем до 10
    final trimmed = digitsOnly.substring(0, 10);
    return '+7 (${trimmed.substring(0, 3)}) ${trimmed.substring(3, 6)}-${trimmed.substring(6, 8)}-${trimmed.substring(8, 10)}';
  }

  /// Отправить код и перейти на экран ввода SMS кода
  /// Навигация происходит в ViewModel согласно MVVM принципам
  Future<void> sendCode() async {
    if (!_isPhoneValid) return;

    setBusy(true);
    try {
      // Здесь будет вызов API для отправки SMS кода
      await Future.delayed(const Duration(seconds: 1)); // Симуляция запроса

      // Навигация в ViewModel - правильный подход для MVVM
      _navigationService.goToSmsCode(_phoneNumber);
    } finally {
      setBusy(false);
    }
  }
}

