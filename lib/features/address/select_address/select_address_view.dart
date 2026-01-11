import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';
import 'package:adm_panel_v2/features/address/address.dart';
import 'package:adm_panel_v2/models/UserAddress.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:adm_panel_v2/components/app_app_bar.dart';
import 'package:adm_panel_v2/features/address/select_address/select_address_viewmodel.dart';

/// Экран выбора адреса
class SelectAddressView extends StatelessWidget {
  late final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectAddressViewModel>.reactive(
      viewModelBuilder: () => SelectAddressViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppAppBar.standard(
            title: 'Выбор адреса',
            showBackButton: true,
          ),
          body: _buildBody(context, model),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SelectAddressViewModel model) {
    return AppFloatingPanelStack(
      controller: _panelController,
      background: Stack(
        children: [
          YandexMap(
            mapType: model.mapType,
            onMapCreated: (controller) {
              model.initMapController(controller);
            },
            onMapTap: (point) {
              model.onMapTap(point);
            },
            mapObjects: model.placemarks,
          )
        ],
      ),
      panel: AddressSearchView(
        onAddressSelected: (userAddress) {
          print("onAddressSelected>>>>" + userAddress.address.toString());
          // Возвращаем результат через pop
          if (context.canPop()) {
            context.pop(userAddress); // ⭐ Возвращаем результат
          }
        },
      ),
      minHeight: 0.3, // 30% экрана
      maxHeight: 0.8, // 80% экрана
      initialHeight: 0.3, // Начальная высота 30%
      snapPoints: [0.3, 0.5, 0.8], // Snap позиции: 30%, 50%, 80%
      showDragHandle: true,
    );
  }
}
