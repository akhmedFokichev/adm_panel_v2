import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../../models/UserAddress.dart';
import '../../../router/navigation_service.dart';

/// Модель сохраненного адреса пользователя

/// ViewModel для экрана "Мои адреса"
class MyAddressesViewModel extends BaseViewModel {
  final _navigationService = GetIt.instance<NavigationService>();

  // Список сохраненных адресов пользователя
  List<UserAddress> _myAddresses = [];

  // Флаг загрузки адресов
  bool _isLoading = false;

  List<UserAddress> get myAddresses => _myAddresses;

  bool get isLoading => _isLoading;

  bool get hasAddresses => _myAddresses.isNotEmpty;

  /// Инициализация экрана - загрузка сохраненных адресов
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    // TODO: Загрузить адреса из локального хранилища или API
    await Future.delayed(const Duration(milliseconds: 500));

    // Пример данных (заменить на реальную загрузку)
    _myAddresses = [
      // SavedAddress(
      //   id: '1',
      //   address: 'Москва, ул. Тверская, д. 1',
      //   description: 'Центральный административный округ',
      //   latitude: 55.7558,
      //   longitude: 37.6173,
      //   label: 'Дом',
      //   isDefault: true,
      // ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  /// Удалить адрес из списка
  /// 
  /// [addressId] - ID адреса для удаления
  Future<void> deleteAddress(String addressId) async {
    // _myAddresses.removeWhere((address) => address.id == addressId);
    notifyListeners();
    // TODO: Сохранить изменения в локальное хранилище или API
  }

  /// Установить адрес как адрес по умолчанию
  /// 
  /// [addressId] - ID адреса для установки как адрес по умолчанию
  Future<void> setDefaultAddress(String addressId) async {
    // _savedAddresses = _savedAddresses.map((address) {
    //   return SavedAddress(
    //     id: address.id,
    //     address: address.address,
    //     description: address.description,
    //     latitude: address.latitude,
    //     longitude: address.longitude,
    //     label: address.label,
    //     isDefault: address.id == addressId,
    //   );
    // }).toList();
    // notifyListeners();
    // // TODO: Сохранить изменения в локальное хранилище или API
  }

  /// [address] - адрес для добавления
  Future<void> tapAddAddress() async {
    /// Открыть поиск адреса и получить результат
    final address = await _navigationService.goToSelectAddressForResult<
        UserAddress>();

    if (address != null) {
      print("object" + address.address.toString());

      myAddresses.add(address);
      notifyListeners();

      // Сохраняем выбранный адрес
    }
  }

  Future<void> tapSelectAddress() async {
    /// Открыть поиск адреса и получить результат

    _navigationService.goToMain();
    // final address = await _navigationService.goToSelectAddressForResult<UserAddress>();
    //
    // if (address != null) {
    //   print("object" + address.address.toString());
    //
    //   myAddresses.add(address);
    //   notifyListeners();

    // Сохраняем выбранный адрес
  }
}

