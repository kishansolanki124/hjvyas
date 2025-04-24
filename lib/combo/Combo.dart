import 'package:flutter/material.dart';

import 'ComboWidget.dart';

class ComboStateless extends StatefulWidget {
  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  ComboStateless({required this.updateBottomNavBarVisibility});

  @override
  State<ComboStateless> createState() => _ComboStatelessState();
}

class _ComboStatelessState extends State<ComboStateless> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Combowidget(
        // gridItems: [
        //   {
        //     'imageUrl': 'https://picsum.photos/id/6/400/800',
        //     'title': 'Blissful Bites Basket',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Majestic Morsels Combo',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Valvet Craving Spread',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Radiant Crave Bundle',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl': 'https://picsum.photos/id/4/400/800',
        //     'title': 'Item 5',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl': 'https://picsum.photos/id/3/400/800',
        //     'title': 'Item 6',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl': 'https://picsum.photos/id/6/400/800',
        //     'title': 'Item 1',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Item 2',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Item 3',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl':
        //         'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        //     'title': 'Item 4',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl': 'https://picsum.photos/id/4/400/800',
        //     'title': 'Item 5',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        //   {
        //     'imageUrl': 'https://picsum.photos/id/3/400/800',
        //     'title': 'Item 6',
        //     'price': '₹ 900.00 - 300 grams',
        //     'calories': 'Calories: 470',
        //     'productLife': 'Product life: 300 days',
        //   },
        // ],
        updateBottomNavBarVisibility: widget.updateBottomNavBarVisibility,
      ),
    );
  }
}
