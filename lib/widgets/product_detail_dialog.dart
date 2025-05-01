import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/cart_bloc.dart';

class ProductDetailsDialog extends StatefulWidget {
  final Product product;
  const ProductDetailsDialog({required this.product});

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 200, vertical: 20),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: isMobile
                ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(context, product, isMobile),
              ),
            )
                : Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(product.fullImageUrl, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildContent(context, product, isMobile),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, Product product, bool isMobile) {
    return [
      if (isMobile)
        Image.network(product.fullImageUrl, fit: BoxFit.cover),
      SizedBox(height: 12),
      Text(product.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('\$${product.price}', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
      SizedBox(height: 4),
      Row(
        children: [
          Text('Available: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('in-stock', style: TextStyle(color: Colors.green)),
        ],
      ),
      SizedBox(height: 12),
      Text(product.desc, style: TextStyle(fontSize: 14)),
      SizedBox(height: 16),

      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) setState(() => quantity--);
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() => quantity++),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: () {
              final cart = BlocProvider.of<CartBloc>(context);
              for (int i = 0; i < quantity; i++) {
                cart.add(AddToCart(product));
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Add to cart',
              style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      SizedBox(height: 20),
      showText("SKU: " , product.sku),
      showText("Categories: " ,product.category),
      showText("Tags: " , product.tag),
    ];
  }

   showText(String title, String subTitle){
    return Row(
      children: [
        Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w700
        ),),
        SizedBox(width: 4.0,),
        Text(subTitle)
      ],
    );
  }
}
