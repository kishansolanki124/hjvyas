import 'package:flutter/material.dart';

import 'ComboWidget.dart';

class ComboStateless extends StatefulWidget {
  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  const ComboStateless({super.key, required this.updateBottomNavBarVisibility});

  @override
  State<ComboStateless> createState() => _ComboStatelessState();
}

class _ComboStatelessState extends State<ComboStateless> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComboWidget(
        updateBottomNavBarVisibility: widget.updateBottomNavBarVisibility,
      ),
    );
  }
}
