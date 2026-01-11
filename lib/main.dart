import 'package:flutter/material.dart';
import 'package:adm_panel_v2/app/app.dart';
import 'package:adm_panel_v2/services/storage_service.dart';
import 'package:adm_panel_v2/app/app.dart' show getIt, setupLocator, MyApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализируем StorageService перед setupLocator
  final storageService = StorageService();
  await storageService.initialize();
  
  // Регистрируем уже инициализированный экземпляр
  getIt.registerSingleton<StorageService>(storageService);
  
  setupLocator();
  runApp(const MyApp());
}
