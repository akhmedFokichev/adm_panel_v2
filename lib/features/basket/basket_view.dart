import 'package:flutter/material.dart';
import 'package:adm_panel_v2/features/basket/view/basket_item_view.dart';
import 'package:adm_panel_v2/features/basket/view/basket_total_view.dart';
import 'package:adm_panel_v2/models/basket_shop.dart';
import 'package:adm_panel_v2/models/cart_item.dart';
import 'package:stacked/stacked.dart';

import '../../components/components.dart';
import '../../design/design_system.dart';
import 'basket_viewmodel.dart';

class BasketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BasketViewmodel>.reactive(
      viewModelBuilder: () => BasketViewmodel(),
      onViewModelReady: (viewModel) {
        viewModel.initialize();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: _buildAppBar(context, viewModel),
        body: _buildBody(context, viewModel),
      ),
    );
  }

  AppAppBar _buildAppBar(BuildContext context, BasketViewmodel viewModel) {
    return AppAppBar.extended(
        title: 'Корзина',
        automaticallyImplyLeading: false,
        bottomWidget: viewModel.cuurentBasket == null
            ? null
            : _buildCartFilterView(viewModel));
  }

  Widget _buildCartFilterView(BasketViewmodel viewModel) {
    return AppScrollableLabels(
      labels: viewModel.labels,
      selectedIds: viewModel.selectedLabelIds,
      onLabelTap: (id) {
        viewModel.toggleLabelSelection(id);
      },
      allowMultipleSelection: false,
    );
  }

  Widget _buildBody(BuildContext context, BasketViewmodel viewModel) {
    final cuurentBasket = viewModel.cuurentBasket;

    return cuurentBasket == null
        ? _buildEmptyCart()
        : _buildBodyContent(context, viewModel, cuurentBasket);
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 24),
          Text(
            'Корзина пуста',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Добавьте товары в корзину',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(
      BuildContext context, BasketViewmodel viewModel, BasketShop basketShop) {
    final totalPrice = viewModel.totalPriceWithBasket(basketShop.id);
    return Column(
      children: [
        Expanded(
          child: _buildListCart(context,
              viewModel), // ListView теперь может занимать доступное пространство
        ),
        BasketTotalView(
            basketShop: basketShop,
            totalPrice: totalPrice,
            totalQuantity: 123,
            tapBay: (shop) => viewModel.tapBay(shop))
      ],
    );
  }

  Widget _buildListCart(BuildContext context, BasketViewmodel viewModel) {
    final cartItems = viewModel.cartItems;

    if (cartItems.isEmpty) {
      return _buildEmptyCart();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: cartItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index >= cartItems.length) {
          return const SizedBox.shrink();
        }
        final item = cartItems[index];
        return _buildCartItemCard(context, viewModel, item);
      },
    );
  }

  Widget _buildCartItemCard(
      BuildContext context, BasketViewmodel viewModel, CartItem cartItem) {
    return BasketItemView(
      cartItem: cartItem,
      tapAdd: (item) => viewModel.addCartItem(item),
      tapRemove: (item) => viewModel.removeCartItem(item),
    );
  }
}
