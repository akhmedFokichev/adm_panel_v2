import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/router/navigation_service.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = GetIt.instance<NavigationService>();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    // Симуляция загрузки данных
    await Future.delayed(const Duration(seconds: 2));
    _isInitialized = true;
    notifyListeners();

    // Навигация в ViewModel


    // Открыть экран поиска адреса и получить результат

   // _navigationService.goToMyAddresses();

    // final address =
    //     await _navigationService.goToAddressSearchForResult<AddressResult>();
    // if (address != null) {
    //   print('Выбранный адрес: ${address.address}');
    //   print('Координаты: ${address.latitude}, ${address.longitude}');
    //
    //   _navigationService.goToMap();
    //   // Здесь можно обработать выбранный адрес
    // } else {
    //   print('Адрес не был выбран');
    // }

    // _navigationService.goToList();

  _navigationService.goToMain();
  //   _navigationService.goToDesignSystem();

  }
}
