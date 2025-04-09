import 'package:flutter/material.dart';

Widget AboutUsWidget() {
  return Column(
    children: [
      Text("We Serve The Best Quality Food"),
      Text(
        textAlign: TextAlign.justify,
        "Discover the Ultimate Sweet Experience with\nH.J. Vyas Mithaiwala.\n\nPicture yourself savoring the most exquisite\nsweets, no matter where your adventures take\nyou. From bustling cities to quiet countryside re-\ntreats, whether you're in Tokyo, Sydney, Rio de\nJaneiro, Cape Town, or Toronto, you can now\nrelish the premium sweets from the 'City of\nSweets', Jamnagar, Gujarat, India. It sounds too\ngood to be true, doesn't it?\n\nSince 1908, H.J. Vyas Mithaiwala has been synon-\nymous with exceptional quality in sweet manu-\nfacturing. Our commitment to our customers'\nhealth and satisfaction ensures that every prod-\nuct meets the highest standards of purity and\ntaste. If you ever have concerns about your or-\nder's taste, quality, or quantity, we back our\nproducts with a money-back guarantee.\n\nWe are dedicated to maintaining the integrity\nand excellence of our sweets. With a legacy\nspanning 116 years, we continue to strengthen\nour bond with our customers by delivering un-\nparalleled quality. Whether you choose to in",
        style: TextStyle(
          fontFamily: "Montserrat",
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      SizedBox(height: 100),
    ],
  );
}
