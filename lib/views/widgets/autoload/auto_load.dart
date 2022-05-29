import 'package:flutter/material.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';

class AutoLoad extends StatefulWidget {
  final CategoryController? onInit;
  final Widget? child;

  const AutoLoad({required this.onInit, required this.child});

  @override
  _AutoLoadState createState() => _AutoLoadState();
}

class _AutoLoadState extends State<AutoLoad> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      print("WidgetsBinding");

      if (widget.onInit != null) {
        //widget.onInit!();
        widget.onInit?.getCategories();
      }

    });
  }

  void runFuctiion() {
    if (widget.onInit != null) {
      //widget.onInit!();
      widget.onInit?.getCategories();
    }
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget.child!,
    );
  }
}
