import 'package:flutter/material.dart';
import 'package:taskapp/widgets/product_detail_dialog.dart';
import '../models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isWeb = MediaQuery.of(context).size.width > 600;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => ProductDetailsDialog(product: product),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        product.fullImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (product.name.toLowerCase().contains("out of stock"))
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.black,
                          child: Text("Out of Stock",
                              style: TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    if (isWeb)
                      AnimatedOpacity(
                        opacity: isHovered ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _circleIcon(Icons.touch_app),
                              SizedBox(width: 10),
                              _circleIcon(Icons.shopping_bag_outlined),
                              SizedBox(width: 10),
                              _circleIcon(Icons.favorite_border),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4),
                    Text('\$${product.price}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Icon(icon, size: 16),
    );
  }
}
