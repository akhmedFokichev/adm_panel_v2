import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/app/app_config.dart';
import 'package:adm_panel_v2/models/UserAddress.dart';
import 'package:adm_panel_v2/network/models/responses/address_search_response.dart';
import 'package:adm_panel_v2/services/address_search_service.dart';
import 'package:stacked/stacked.dart';

import '../../../network/models/requests/address_search_request.dart';
import '../../../router/navigation_service.dart';

class AddressSearchViewModel extends BaseViewModel {
  final _navigationService = GetIt.instance<NavigationService>();
  final _addressSearchService = GetIt.instance<AddressSearchService>();

  // TextEditingController для поля поиска
  late final TextEditingController searchController;

  // Таймер для debounce
  Timer? _debounceTimer;

  // Текущий поисковый запрос, введенный пользователем
  String _searchQuery = '';

  // Список недавних поисковых запросов (история поиска)
  List<String> _recentSearches = [];

  // Список найденных адресов в результате поиска
  List<UserAddress> _searchResults = [];

  // Флаг, указывающий, выполняется ли в данный момент поиск адресов
  bool _isSearching = false;

  AddressSearchViewModel() {
    searchController = TextEditingController();
    _setupSearchListener();
  }

  /// Настройка слушателя изменений текста с debounce
  void _setupSearchListener() {
    searchController.addListener(() {
      final query = searchController.text;

      // Отменяем предыдущий таймер
      _debounceTimer?.cancel();

      // Если запрос пустой, сразу обновляем (без задержки)
      if (query.isEmpty) {
        updateSearchQuery(query);
        return;
      }

      // Debounce: ждем 500ms перед отправкой запроса
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        // Вызываем только если текст не изменился за это время
        if (searchController.text == query) {
          updateSearchQuery(query);
        }
      });
    });
  }

  // Геттер для получения текущего поискового запроса
  String get searchQuery => _searchQuery;

  // Геттер для получения списка недавних поисков
  List<String> get recentSearches => _recentSearches;

  // Геттер для получения списка найденных адресов
  List<UserAddress> get searchResults => _searchResults;

  // Геттер для проверки, выполняется ли поиск в данный момент
  bool get isSearching => _isSearching;

  // Геттер для проверки, есть ли результаты поиска
  bool get hasResults => _searchResults.isNotEmpty;

  // Геттер для проверки, нужно ли показывать историю поисков
  bool get showRecentSearches =>
      _searchQuery.isEmpty && _recentSearches.isNotEmpty;

  /// Обновляет поисковый запрос и выполняет поиск адресов
  Future<void> updateSearchQuery(String query) async {
    _searchQuery = query;

    // Если запрос пустой, очищаем результаты
    if (query.trim().isEmpty) {
      _searchResults.clear();
      _isSearching = false;
      notifyListeners();
      return;
    }

    // Проверка минимальной длины
    if (query.trim().length < 2) {
      _searchResults.clear();
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      final ll = GeoMapPoint(longitudeSpan: 43.635615, latitudeSpan: 43.485793);
      final searchRadiusKm = 5.0;       // Радиус поиска в километрах (например, 5 км)
      final span = SearchSpan.fromRadiusKm(searchRadiusKm);

      final request = AddressSearchRequest(
        geocode: query,
        lang: 'ru_RU',
        results: 15,
        kind: 'house',
        rspn: 0,
        spn: span,
        ll: ll,
      );

      final response = await _addressSearchService.search(
        request: request,
        apiKey: AppConfig.yandexApiKey,
      );

      _isSearching = false;

      if (response.data != null) {
        handlerResponseSearchAddress(response.data!);
      } else {
        print('Ошибка: ${response.message}');
        _searchResults.clear();
        notifyListeners();
      }
    } catch (e) {
      print('Ошибка при поиске адресов: $e');
      _isSearching = false;
      _searchResults.clear();
      notifyListeners();
    }
  }

  void handlerResponseSearchAddress(AddressSearchResponse data) {
    final addresses = data.response.geoObjectCollection.featureMember;

    _searchResults = addresses.map((member) {
      final geo = member.geoObject;
      final coords = geo.point.getCoordinates();
      return UserAddress(
        address: geo.metaDataProperty?.text ?? geo.name,
        description: geo.description,
        latitude: coords[1],
        longitude: coords[0],
      );
    }).toList();

    notifyListeners();
  }

  /// Очищает текущий поисковый запрос и результаты поиска
  void clearSearch() {
    _searchQuery = '';
    _searchResults.clear();
    searchController.clear();
    notifyListeners();
  }

  /// Удаляет конкретный запрос из истории недавних поисков
  void removeRecentSearch(String query) {
    _recentSearches.remove(query);
    notifyListeners();
  }

  /// Очищает всю историю недавних поисков
  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  /// Выбирает адрес из результатов поиска
  void tapSelectAddress(String address) {
    print("tapSelectAddress" + address);
    //addToRecentSearches(address.address);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }
}