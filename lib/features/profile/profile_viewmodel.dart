
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/router/navigation.dart';
import 'package:adm_panel_v2/services/location_service.dart';
import 'package:stacked/stacked.dart';

import '../../services/storage_service.dart';

class ProfileViewmodel extends BaseViewModel {
  final navigationService = GetIt.instance<NavigationService>();
  final locationService = GetIt.instance<LocationService>();
  final storageService = GetIt.instance<StorageService>();


  initialize() {

    // storageService.saveString("test1", "warcraft3");
  }

  void tapMyAddress() {
   // navigationService.goToMyAddresses();
   //  final value = storageService.getString("test1") ?? "null";
   //  print("value>" + value);
  }

  void tapExit() {
    navigationService.goToLogin();
  }
}