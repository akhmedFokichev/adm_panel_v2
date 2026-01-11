import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../design/design_system.dart';
import '../../../models/cart_item.dart';

class BasketItemView extends StatelessWidget {
  final CartItem cartItem;
  final ValueChanged<CartItem> tapAdd;
  final ValueChanged<CartItem> tapRemove;

  const BasketItemView(
      {required this.cartItem, required this.tapAdd, required this.tapRemove});

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          _buildImage(),
          const SizedBox(width: 16),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Icon(
        Icons.fastfood_outlined,
        color: AppColors.textTertiary,
        size: 32,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          cartItem.name,
          style: AppTextStyles.titleMedium,
        ),
        if (cartItem.description != null) ...[
          const SizedBox(height: 4),
          Text(
            cartItem.description!,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
        const SizedBox(height: 4),

        Text(cartItem.totalPrice.toString()),

        const SizedBox(height: 8),
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return AppCounter(
      label: "",
      value: cartItem.quantity,
      onChanged: (value) {
        if (value > cartItem.quantity) {
          tapAdd(cartItem);
        } else if (value < cartItem.quantity) {
          tapRemove(cartItem);
        }
      },
    );
  }
}
//
// Material(
// color: Colors.transparent,
// child: InkWell(
// onTap: () => model.updateQuantity(item.id, item.quantity + 1),
// borderRadius: BorderRadius.circular(8),
// child: const Icon(
// Icons.add,
// size: 16,
// color: AppColors.textOnPrimary,
// ),
// ),
// ),
