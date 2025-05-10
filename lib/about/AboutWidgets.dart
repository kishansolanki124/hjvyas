import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../api/models/StaticPageResponse.dart';

Widget AboutUsContentWidget(
  String webpageTitle,
  List<StaticpageListItem> staticpageList,
) {
  return Expanded(
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Change to .stretch
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              // Added Expanded here
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 75),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),

                          //load html content
                          if (webpageTitle == "About Us")
                            loadHTMLContent(
                              getItemByName(
                                staticpageList,
                                "About Us",
                              )!.description,
                            ),

                          if (webpageTitle == "Refund Policy")
                            loadHTMLContent(
                              getItemByName(
                                staticpageList,
                                "Refund Policy",
                              )!.description,
                            ),

                          if (webpageTitle == "Privacy Policy")
                            loadHTMLContent(
                              getItemByName(
                                staticpageList,
                                "Privacy Policy",
                              )!.description,
                            ),

                          if (webpageTitle == "Terms")
                            loadHTMLContent(
                              getItemByName(
                                staticpageList,
                                "Terms",
                              )!.description,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Center(
              child: Container(
                color: Color.fromARGB(255, 31, 47, 80),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    webpageTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StaticpageListItem? getItemByName(List<StaticpageListItem> items, String name) {
  for (var item in items) {
    if (item.name == name) {
      return item;
    }
  }
  return null; // Return null if no item with the given name is found.
}

Widget loadHTMLContent(String? stringData) {
  return Html(
    data: stringData,
    style: {
      //"h1": Style(fontSize: FontSize.xxLarge),
      "p": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.medium,
        textAlign: TextAlign.justify,
        color: Colors.white,
      ),
      "body": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.medium,
        textAlign: TextAlign.justify,
        color: Colors.white,
      ),
      "<br>": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.medium,
        textAlign: TextAlign.justify,
        color: Colors.white,
      ),
      "strong": Style(
        fontWeight: FontWeight.w600,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.large,
        textAlign: TextAlign.justify,
        color: Colors.white,
      ),
      //"a": Style(color: Colors.blue, decoration: TextDecoration.underline),
      //"table": Style(border: Border.all(color: Colors.grey)),
      //"th": Style(padding: EdgeInsets.all(8), backgroundColor: Colors.lightBlue),
      //"td": Style(padding: EdgeInsets.all(8)),
      //"div": Style(margin: EdgeInsets.only(bottom: 10)),
      // "img": Style(
      //   width: Width.percent(100), // Make images responsive.
      //   height: Height.auto(),
      // ),
    },
  );
}

Widget loadHTMLContentPopup(String? stringData) {
  return Html(
    data: stringData,
    style: {
      //"h1": Style(fontSize: FontSize.xxLarge),
      "p": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        textAlign: TextAlign.justify,
        fontFamily: "Montserrat",
        fontSize: FontSize.xSmall,
        color: Colors.black,
      ),
      "body": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.small,
        textAlign: TextAlign.justify,
        color: Colors.black,
      ),
      "<br>": Style(
        fontWeight: FontWeight.w400,
        //fontSize: 14,
        fontFamily: "Montserrat",
        textAlign: TextAlign.justify,
        fontSize: FontSize.xSmall,
        color: Colors.white,
      ),
      "strong": Style(
        fontWeight: FontWeight.w600,
        //fontSize: 14,
        fontFamily: "Montserrat",
        fontSize: FontSize.xSmall,
        textAlign: TextAlign.justify,
        color: Colors.black,
      ),
      //"a": Style(color: Colors.blue, decoration: TextDecoration.underline),
      //"table": Style(border: Border.all(color: Colors.grey)),
      //"th": Style(padding: EdgeInsets.all(8), backgroundColor: Colors.lightBlue),
      //"td": Style(padding: EdgeInsets.all(8)),
      //"div": Style(margin: EdgeInsets.only(bottom: 10)),
      // "img": Style(
      //   width: Width.percent(100), // Make images responsive.
      //   height: Height.auto(),
      // ),
    },
  );
}
