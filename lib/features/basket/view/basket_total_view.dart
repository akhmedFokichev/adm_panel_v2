import 'package:flutter/material.dart';
import 'package:adm_panel_v2/models/basket_shop.dart';

import '../../../components/components.dart';

class BasketTotalView extends StatelessWidget {
  final BasketShop basketShop;
  final double totalPrice;
  final int totalQuantity;
  final ValueChanged<BasketShop> tapBay;

  const BasketTotalView({
    required this.basketShop,
    required this.totalPrice,
    required this.totalQuantity,
    required this.tapBay
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 16),
            Text(
                "Итого:"
            ),
            Spacer(),
            Text(
                 totalPrice.toString(),
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 8),
        AppButton(label: "Оформить заказ: " + totalPrice.toString()),
        SizedBox(height: 16)
      ],
    );
  }
}