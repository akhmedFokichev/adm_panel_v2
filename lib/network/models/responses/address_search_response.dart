/// Модель для поиска адреса в yandex map sdk
class AddressSearchResponse {
  final GeocoderResponse response;

  AddressSearchResponse({
    required this.response,
  });

  factory AddressSearchResponse.fromJson(Map<String, dynamic> json) {
    return AddressSearchResponse(
      response: GeocoderResponse.fromJson(
        json['response'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response.toJson(),
    };
  }
}

/// Основной объект ответа
class GeocoderResponse {
  final GeoObjectCollection geoObjectCollection;

  GeocoderResponse({
    required this.geoObjectCollection,
  });

  factory GeocoderResponse.fromJson(Map<String, dynamic> json) {
    return GeocoderResponse(
      geoObjectCollection: GeoObjectCollection.fromJson(
        json['GeoObjectCollection'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GeoObjectCollection': geoObjectCollection.toJson(),
    };
  }
}

/// Коллекция геообъектов
class GeoObjectCollection {
  final GeocoderResponseMetaData? metaDataProperty;
  final List<FeatureMember> featureMember;

  GeoObjectCollection({
    this.metaDataProperty,
    required this.featureMember,
  });

  factory GeoObjectCollection.fromJson(Map<String, dynamic> json) {
    return GeoObjectCollection(
      metaDataProperty: json['metaDataProperty'] != null
          ? GeocoderResponseMetaData.fromJson(
        json['metaDataProperty'] as Map<String, dynamic>,
      )
          : null,
      featureMember: (json['featureMember'] as List<dynamic>?)
          ?.map((item) => FeatureMember.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (metaDataProperty != null)
        'metaDataProperty': metaDataProperty!.toJson(),
      'featureMember': featureMember.map((item) => item.toJson()).toList(),
    };
  }
}

/// Метаданные ответа геокодера
class GeocoderResponseMetaData {
  final String request;
  final String found;
  final String results;

  GeocoderResponseMetaData({
    required this.request,
    required this.found,
    required this.results,
  });

  factory GeocoderResponseMetaData.fromJson(Map<String, dynamic> json) {
    final geocoderMeta = json['GeocoderResponseMetaData'] as Map<String, dynamic>;
    return GeocoderResponseMetaData(
      request: geocoderMeta['request'] as String,
      found: geocoderMeta['found'] as String,
      results: geocoderMeta['results'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GeocoderResponseMetaData': {
        'request': request,
        'found': found,
        'results': results,
      },
    };
  }
}

/// Элемент коллекции (один результат поиска)
class FeatureMember {
  final GeoObject geoObject;

  FeatureMember({
    required this.geoObject,
  });

  factory FeatureMember.fromJson(Map<String, dynamic> json) {
    return FeatureMember(
      geoObject: GeoObject.fromJson(
        json['GeoObject'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GeoObject': geoObject.toJson(),
    };
  }
}

/// Геообъект
class GeoObject {
  final String name;
  final String? description;
  final GeoPoint point;
  final GeocoderMetaData? metaDataProperty;

  GeoObject({
    required this.name,
    this.description,
    required this.point,
    this.metaDataProperty,
  });

  factory GeoObject.fromJson(Map<String, dynamic> json) {
    return GeoObject(
      name: json['name'] as String,
      description: json['description'] as String?,
      point: GeoPoint.fromJson(
        json['Point'] as Map<String, dynamic>,
      ),
      metaDataProperty: json['metaDataProperty'] != null
          ? GeocoderMetaData.fromJson(
        json['metaDataProperty'] as Map<String, dynamic>,
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'Point': point.toJson(),
      if (metaDataProperty != null)
        'metaDataProperty': metaDataProperty!.toJson(),
    };
  }
}

/// Точка на карте
class GeoPoint {
  /// Координаты в формате "долгота широта" (например, "37.617635 55.755814")
  final String pos;

  GeoPoint({
    required this.pos,
  });

  factory GeoPoint.fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      pos: json['pos'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pos': pos,
    };
  }

  /// Получить координаты как Point (для yandex_mapkit)
  /// Возвращает [longitude, latitude]
  List<double> getCoordinates() {
    final parts = pos.split(' ');
    if (parts.length != 2) {
      throw FormatException('Invalid pos format: $pos');
    }
    return [
      double.parse(parts[0]), // longitude
      double.parse(parts[1]), // latitude
    ];
  }

  /// Получить широту
  double get latitude => getCoordinates()[1];

  /// Получить долготу
  double get longitude => getCoordinates()[0];
}

/// Метаданные геокодера для конкретного объекта
class GeocoderMetaData {
  final String text;
  final String? precision;
  final String? kind;
  final GeoAddress? address;

  GeocoderMetaData({
    required this.text,
    this.precision,
    this.kind,
    this.address,
  });

  factory GeocoderMetaData.fromJson(Map<String, dynamic> json) {
    final geocoderMeta = json['GeocoderMetaData'] as Map<String, dynamic>;
    return GeocoderMetaData(
      text: geocoderMeta['text'] as String,
      precision: geocoderMeta['precision'] as String?,
      kind: geocoderMeta['kind'] as String?,
      address: geocoderMeta['Address'] != null
          ? GeoAddress.fromJson(
        geocoderMeta['Address'] as Map<String, dynamic>,
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GeocoderMetaData': {
        'text': text,
        if (precision != null) 'precision': precision,
        if (kind != null) 'kind': kind,
        if (address != null) 'Address': address!.toJson(),
      },
    };
  }
}

/// Адрес геообъекта
class GeoAddress {
  final String? countryCode;
  final String? formatted;
  final List<AddressComponent>? components;

  GeoAddress({
    this.countryCode,
    this.formatted,
    this.components,
  });

  factory GeoAddress.fromJson(Map<String, dynamic> json) {
    return GeoAddress(
      countryCode: json['country_code'] as String?,
      formatted: json['formatted'] as String?,
      components: json['Components'] != null
          ? (json['Components'] as List<dynamic>)
          .map((item) => AddressComponent.fromJson(item as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (countryCode != null) 'country_code': countryCode,
      if (formatted != null) 'formatted': formatted,
      if (components != null)
        'Components': components!.map((item) => item.toJson()).toList(),
    };
  }
}

/// Компонент адреса
class AddressComponent {
  final String kind;
  final String name;

  AddressComponent({
    required this.kind,
    required this.name,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      kind: json['kind'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kind': kind,
      'name': name,
    };
  }
}