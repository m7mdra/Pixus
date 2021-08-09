import 'package:flutter/material.dart';
import 'package:pix/data/model/order.dart';

class OrderSelectionWidget extends StatelessWidget {
  final ValueChanged<Order>? onSelect;
  final Order order;

  const OrderSelectionWidget(
      {Key? key, this.onSelect, this.order = Order.popular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Order',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        PopupMenuButton<Order>(
          child: Chip(label: Text(order.name)),
          itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text("Popular"), value: Order.popular),
              PopupMenuItem(child: Text("Latest"), value: Order.latest),
            ];
          },
          onSelected: onSelect,
        ),
      ],
    );
  }
}
