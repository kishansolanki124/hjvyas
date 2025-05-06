import 'package:flutter/material.dart';
import 'package:hjvyas/about/AboutWidgets.dart';
import 'package:hjvyas/product_detail/ProductDetailWidget.dart';

import '../api/models/StaticPageResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../menu/CategoryController.dart';
import '../repositories/HJVyasRepository.dart';

class TermsAndConditionPopup extends StatefulWidget {
  final CategoryController categoryController = CategoryController(
    getIt<HJVyasApiService>(),
  );

  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  final String imageUrl;
  final Function() onClose;

  TermsAndConditionPopup({
    super.key,
    required this.imageUrl,
    required this.onClose,
  });

  @override
  State<TermsAndConditionPopup> createState() => _TermsAndConditionPopupState();
}

class _TermsAndConditionPopupState extends State<TermsAndConditionPopup> {
  StaticPageResponse? staticPage;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getStaticPage() async {
    staticPage = await widget._userRepo.getStaticpage();
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 31, 47, 80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  //top center title
                  backButton(() => _onBackPressed(context)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Terms & Condition",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //html content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [loadHTMLContent(widget.imageUrl)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
