import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/router/navigation_service.dart';

class SmsCodeViewModel extends BaseViewModel {
  final _navigationService = GetIt.instance<NavigationService>();

  final String phoneNumber;
  String _code = '';
  bool _isCodeValid = false;
  int _resendTimer = 60;
  String? _errorMessage;

  SmsCodeViewModel(this.phoneNumber) {
    _startResendTimer();
  }

  String get code => _code;
  bool get isCodeValid => _isCodeValid;
  int get resendTimer => _resendTimer;
  bool get canResend => _resendTimer == 0;
  String? get errorMessage => _errorMessage;

  void updateCode(String newCode) {
    _code = newCode;
    _isCodeValid = _code.length == 6;
    _errorMessage = null; // Сбрасываем ошибку при изменении кода
    notifyListeners();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendTimer > 0) {
        _resendTimer--;
        notifyListeners();
      }
      return _resendTimer > 0;
    });
  }

  Future<void> resendCode() async {
    if (!canResend) return;

    setBusy(true);
    try {
      // Здесь будет вызов API для повторной отправки SMS кода
      await Future.delayed(const Duration(seconds: 1)); // Симуляция запроса
      _resendTimer = 60;
      _startResendTimer();
    } finally {
      setBusy(false);
    }
  }

  /// Проверить код и перейти на главный экран при успехе
  /// Навигация происходит в ViewModel согласно MVVM принципам
  Future<void> verifyCode() async {
    if (!_isCodeValid) {
      _errorMessage = 'Введите код из 6 цифр';
      notifyListeners();
      return;
    }

    setBusy(true);
    _errorMessage = null;
    notifyListeners();

    try {
      // Здесь будет вызов API для проверки кода
      await Future.delayed(const Duration(seconds: 1)); // Симуляция запроса

      // Симуляция: если код "123456", то успех, иначе ошибка
      final isValid = _code == '123456';

      if (isValid) {
        // Навигация в ViewModel - правильный подход для MVVM
        _navigationService.goToMain();
      } else {
        _errorMessage = 'Неверный код. Попробуйте снова.';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Ошибка при проверке кода. Попробуйте снова.';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}

