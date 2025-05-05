import 'package:flutter/material.dart';

import '../api/models/ProductDetailResponse.dart';

class ProductYouMayLikeItem extends StatefulWidget {
  final ProductMoreListItem productMoreListItem;

  const ProductYouMayLikeItem({super.key, required this.productMoreListItem});

  @override
  State<ProductYouMayLikeItem> createState() => _ProductYouMayLikeItemState();
}

class _ProductYouMayLikeItemState extends State<ProductYouMayLikeItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 12.0),
    child: Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
      ),
      child: Column(
        children: [
          if (widget.productMoreListItem.productImage != null)
            SizedBox(
              height: 110,
              width: 110,
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Image.network(
                  widget.productMoreListItem.productImage,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 60,
                      child: Center(child: Text('Err')),
                    );
                  },
                ),
              ),
            ),

          SizedBox(height: 4),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              widget.productMoreListItem.productName ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Text(
              "₹ ${widget.productMoreListItem.productPrice ?? ''} -  ${widget.productMoreListItem.productWeight}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
