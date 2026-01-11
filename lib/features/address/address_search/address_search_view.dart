import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/components/app_app_bar.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/features/address/address_search/address_search_viewmodel.dart';

import '../../../models/UserAddress.dart';

class AddressSearchView extends StatelessWidget {
  /// Callback для обработки выбранного адреса
  final Function(UserAddress)? onAddressSelected;

  const AddressSearchView({
    super.key,
    this.onAddressSelected,
  });


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressSearchViewModel>.reactive(
      viewModelBuilder: () => AddressSearchViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppAppBar.withSearch(
          searchField: _buildSearchField(context, model),
          showBackButton: false,
        ),
        body: _buildBody(context, model),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, AddressSearchViewModel model) {
    return TextField(
      controller: model.searchController,
      autofocus: true,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Поиск адреса...',
        hintStyle: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textSecondary,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(
          Icons.location_on,
          color: AppColors.textSecondary,
        ),
        suffixIcon: model.searchQuery.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          color: AppColors.textSecondary,
          onPressed: () {
            model.clearSearch();
            FocusScope.of(context).unfocus();
          },
        )
            : null,
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddressSearchViewModel model) {
    if (model.isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (model.showRecentSearches) {
      return _buildRecentSearches(context, model);
    }

    if (model.hasResults) {
      return _buildSearchResults(context, model);
    }

    if (model.searchQuery.isNotEmpty && !model.hasResults) {
      return _buildEmptyResults(context);
    }

    return _buildEmptyState(context);
  }

  Widget _buildRecentSearches(BuildContext context, AddressSearchViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Недавние адреса',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (model.recentSearches.isNotEmpty)
                TextButton(
                  onPressed: model.clearRecentSearches,
                  child: Text(
                    'Очистить',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model.recentSearches.length,
            itemBuilder: (context, index) {
              final address = model.recentSearches[index];
              return ListTile(
                leading: const Icon(
                  Icons.history,
                  color: AppColors.textSecondary,
                ),
                title: Text(
                  address,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => model.removeRecentSearch(address),
                ),
                onTap: () => model.tapSelectAddress(address),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(BuildContext context, AddressSearchViewModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: model.searchResults.length,
      itemBuilder: (context, index) {
        final address = model.searchResults[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            leading: const Icon(
              Icons.location_on,
              color: AppColors.primary,
            ),
            title: Text(
              address.address,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: address.description != null
                ? Text(
              address.description!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            )
                : null,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
            onTap: () {
              // Вызываем callback, если он передан
              if (onAddressSelected != null) {
                onAddressSelected!(address);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyResults(BuildContext context) {
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
            'Адрес не найден',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить запрос',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Icon(
            Icons.location_on_outlined,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Поиск адреса',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Введите адрес в поле поиска',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}