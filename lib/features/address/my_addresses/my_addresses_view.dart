import 'package:flutter/material.dart';
import 'package:adm_panel_v2/models/UserAddress.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/components/app_app_bar.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/features/address/my_addresses/my_addresses_viewmodel.dart';

/// Экран "Мои адреса"
class MyAddressesView extends StatelessWidget {
  const MyAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAddressesViewModel>.reactive(
      viewModelBuilder: () => MyAddressesViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialize();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: _buildAppAppBar(context, viewModel),
          body: _buildBody(context, viewModel),
        );
      },
    );
  }

  AppAppBar _buildAppAppBar(BuildContext context, MyAddressesViewModel viewModel) {
    return AppAppBar.standard(
      title: 'Мои адреса',
      showBackButton: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            viewModel.tapAddAddress();
          },
          tooltip: 'Добавить адрес',
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, MyAddressesViewModel model) {
    if (model.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!model.hasAddresses) {
      return _buildEmptyState(context, model);
    }

    return _buildAddressesList(context, model);
  }

  Widget _buildEmptyState(BuildContext context, MyAddressesViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Нет сохраненных адресов',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Добавьте адрес для быстрого доступа',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Открыть экран добавления адреса
              viewModel.tapAddAddress();
            },
            icon: const Icon(Icons.add),
            label: const Text('Добавить адрес'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressesList(BuildContext context, MyAddressesViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: viewModel.myAddresses.length,
      itemBuilder: (context, index) {
        final address = viewModel.myAddresses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: address.isDefault ? AppColors.primary : AppColors.border,
              width: address.isDefault ? 2 : 1,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            leading: Icon(
              Icons.location_on,
              color: address.isDefault ? AppColors.primary : AppColors.textSecondary,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    address.address,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (address.isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'По умолчанию',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (address != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    address.address!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                if (address.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    address.description!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.textSecondary,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    // TODO: Открыть экран редактирования адреса
                    break;
                  case 'set_default':
                    if (!address.isDefault) {
                      viewModel.setDefaultAddress(address.id);
                    }
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, viewModel, address);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Редактировать'),
                    ],
                  ),
                ),
                if (!address.isDefault)
                  const PopupMenuItem(
                    value: 'set_default',
                    child: Row(
                      children: [
                        Icon(Icons.star_outline, size: 20),
                        SizedBox(width: 8),
                        Text('Сделать по умолчанию'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Удалить', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              viewModel.tapSelectAddress();
              // TODO: Можно открыть детали адреса или выбрать его
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    MyAddressesViewModel model,
    UserAddress address,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить адрес?'),
        content: Text('Вы уверены, что хотите удалить адрес "${address.address}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Отмена',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              model.deleteAddress(address.id);
            },
            child: Text(
              'Удалить',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

