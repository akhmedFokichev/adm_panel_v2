import 'package:stacked/stacked.dart';

class DesignSystemViewModel extends BaseViewModel {
  // Радио-кнопки
  String? _selectedRadioValue = 'selected';
  String? get selectedRadioValue => _selectedRadioValue;

  void setRadioValue(String? value) {
    _selectedRadioValue = value;
    notifyListeners();
  }

  // Чекбоксы
  bool _checkboxDefault = false;
  bool _checkboxSelected = true;
  final bool _checkboxInactiveEmpty = false;
  final bool _checkboxInactiveSelected = true;

  bool get checkboxDefault => _checkboxDefault;
  bool get checkboxSelected => _checkboxSelected;
  bool get checkboxInactiveEmpty => _checkboxInactiveEmpty;
  bool get checkboxInactiveSelected => _checkboxInactiveSelected;

  void setCheckboxDefault(bool value) {
    _checkboxDefault = value;
    notifyListeners();
  }

  void setCheckboxSelected(bool value) {
    _checkboxSelected = value;
    notifyListeners();
  }

  // Счетчики
  int _adultsCount = 1;
  int _childrenCount = 0;

  int get adultsCount => _adultsCount;
  int get childrenCount => _childrenCount;

  void setAdultsCount(int value) {
    _adultsCount = value;
    notifyListeners();
  }

  void setChildrenCount(int value) {
    _childrenCount = value;
    notifyListeners();
  }

  // Navigation bars
  int _bottomNavIndex = 0;
  int _bottomShiftingNavIndex = 0;
  int _pillTabsIndex = 0;

  int get bottomNavIndex => _bottomNavIndex;
  int get bottomShiftingNavIndex => _bottomShiftingNavIndex;
  int get pillTabsIndex => _pillTabsIndex;

  void setBottomNavIndex(int value) {
    _bottomNavIndex = value;
    notifyListeners();
  }

  void setBottomShiftingNavIndex(int value) {
    _bottomShiftingNavIndex = value;
    notifyListeners();
  }

  void setPillTabsIndex(int value) {
    _pillTabsIndex = value;
    notifyListeners();
  }

  // Scrollable Labels (множественный выбор)
  final Set<String> _selectedLabelIds = {'1'};

  Set<String> get selectedLabelIds => _selectedLabelIds;


  void toggleLabel(String labelId) {
    if (_selectedLabelIds.contains(labelId)) {
      _selectedLabelIds.remove(labelId);
    } else {
      _selectedLabelIds.add(labelId);
    }
    notifyListeners();
  }

  void clearSelectedLabels() {
    _selectedLabelIds.clear();
    notifyListeners();
  }

  // Scrollable Labels (режим радиокнопки - одиночный выбор)
  String? _singleSelectedLabelId = '1';

  String? get singleSelectedLabelId => _singleSelectedLabelId;

  void selectSingleLabel(String labelId) {
    _singleSelectedLabelId = labelId;
    notifyListeners();
  }

  Set<String> get singleSelectedLabelIds {
    return _singleSelectedLabelId != null ? {_singleSelectedLabelId!} : {};
  }
}
