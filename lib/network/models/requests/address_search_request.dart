/// Запрос на поиск адреса
class AddressSearchRequest {
  /// Адрес или координаты для геокодирования
  /// Для прямого геокодирования: "Москва"
  /// Для обратного геокодирования: "37.617635,55.755814" (долгота,широта)
  final String geocode;

  /// Язык ответа (ru_RU, en_US, uk_UA, be_BY, tr_TR)
  final String? lang;

  /// Тип топонима (house, street, metro, district, locality)
  final String? kind;

  /// Количество результатов (по умолчанию 10)
  final int? results;

  /// Пропустить N результатов
  final int? skip;

  /// Ограничивающий прямоугольник (x1,y1~x2,y2)
  final String? bbox;

  /// Ограничить поиск областью (0 или 1)
  final int? rspn;

  /// Размер области поиска (параметр spn)
  final SearchSpan? spn;

  /// Формат ответа (по умолчанию json)
  final String? format;

  final GeoMapPoint? ll;

  AddressSearchRequest({
    required this.geocode,
    this.lang,
    this.kind,
    this.results,
    this.skip,
    this.bbox,
    this.rspn,
    this.spn,
    this.format,
    this.ll,
  });

  /// Преобразование в query параметры для URL
  Map<String, String> toQueryParams() {
    final params = <String, String>{
      'geocode': geocode,
    };

    if (lang != null) params['lang'] = lang!;
    if (kind != null) params['kind'] = kind!;
    if (results != null) params['results'] = results.toString();
    if (skip != null) params['skip'] = skip.toString();
    if (bbox != null) params['bbox'] = bbox!;
    if (rspn != null) params['rspn'] = rspn.toString();
    if (spn != null) params['spn'] = spn!.toQueryParam();
    if (format != null) params['format'] = format!;
    if (ll != null) params['ll'] = ll!.toQueryParam();

    return params;
  }
}

class GeoMapPoint {
  /// Протяженность по долготе (в градусах)
  final double longitudeSpan;

  /// Протяженность по широте (в градусах)
  final double latitudeSpan;

  const GeoMapPoint({
    required this.longitudeSpan,
    required this.latitudeSpan,
  })
      : assert(longitudeSpan > 0, 'Longitude span must be positive'),
        assert(latitudeSpan > 0, 'Latitude span must be positive');

  /// Создать квадратную область (одинаковый размер по обеим осям)
  factory GeoMapPoint.square(double span) {
    return GeoMapPoint(
      longitudeSpan: span,
      latitudeSpan: span,
    );
  }

  /// Преобразовать в строку для параметра spn
  /// Формат: "долгота,широта"
  String toQueryParam() => '$longitudeSpan,$latitudeSpan';
}

/// Размер области поиска (параметр spn)
class SearchSpan {
  /// Протяженность по долготе (в градусах)
  final double longitudeSpan;

  /// Протяженность по широте (в градусах)
  final double latitudeSpan;

  const SearchSpan({
    required this.longitudeSpan,
    required this.latitudeSpan,
  })
      : assert(longitudeSpan > 0, 'Longitude span must be positive'),
        assert(latitudeSpan > 0, 'Latitude span must be positive');

  /// Создать квадратную область (одинаковый размер по обеим осям)
  factory SearchSpan.square(double span) {
    return SearchSpan(
      longitudeSpan: span,
      latitudeSpan: span,
    );
  }

  /// Преобразовать в строку для параметра spn
  /// Формат: "долгота,широта"
  String toQueryParam() => '$longitudeSpan,$latitudeSpan';

  /// Создать из размера в километрах (ширина и высота)
  factory SearchSpan.fromSizeKm({
    required double widthKm,
    required double heightKm,
  }) {
    return SearchSpan(
      longitudeSpan: widthKm / 111.0,
      latitudeSpan: heightKm / 111.0,
    );
  }

  factory SearchSpan.fromRadiusKm(double radiusKm) {
    // Конвертируем радиус в градусы
    // Для квадратной области: диаметр = 2 * радиус
    final diameterKm = radiusKm * 2;
    final spanDegrees = diameterKm / 111.0;
    return SearchSpan.square(spanDegrees);
  }
}