import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/models/admin/dashboard_stats.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardStats _stats = DashboardStats.mock();

  DashboardStats get stats => _stats;

  DashboardViewModel() {
    _loadStats();
  }

  Future<void> _loadStats() async {
    setBusy(true);
    try {
      // TODO: Загрузить реальные данные с API
      await Future.delayed(const Duration(seconds: 1));
      _stats = DashboardStats.mock();
      notifyListeners();
    } catch (e) {
      // Обработка ошибок
    } finally {
      setBusy(false);
    }
  }

  Future<void> refresh() async {
    await _loadStats();
  }
}

