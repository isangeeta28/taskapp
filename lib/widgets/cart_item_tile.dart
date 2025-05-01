import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/cart_bloc.dart';

class CartItemTile extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartItemTile({Key? key, required this.product, required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return ListTile(
      leading: Image.network(product.fullImageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(product.name),
      subtitle: Text('Qty: $quantity'),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () {
          cartBloc.add(RemoveFromCart(product));
        },
      ),
    );
  }
}
