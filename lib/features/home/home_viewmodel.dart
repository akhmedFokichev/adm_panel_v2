import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int _counter = 0;
  String _title = 'RU Delivery Home Page';

  int get counter => _counter;
  String get title => _title;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}

