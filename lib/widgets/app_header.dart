import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../screens/cart_screen.dart';

class AppHeader extends StatelessWidget {
  void _showCartDrawer(BuildContext context, CartState state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth < 600 ? screenWidth * 0.75 : screenWidth * 0.3;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.white,
          child: Container(
            width: drawerWidth,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),


                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (state is CartInitial && state.cartItems.isNotEmpty) {
                        return ListView(
                          children: state.cartItems.entries.map((entry) {
                            final item = entry.key;
                            final quantity = entry.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(item.fullImageUrl, width: 60, height: 90, fit: BoxFit.cover),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Text('Qty: $quantity'),
                                        Text('Price: \$${item.price.toStringAsFixed(2)}'),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context).add(RemoveFromCart(item));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Cart is empty", style: TextStyle(fontSize: 16)),
                          ),
                        );
                      }
                    },
                  ),
                ),

                if (state is CartInitial && state.cartItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(
                              '\$${state.cartItems.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value).toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size.fromHeight(45),
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // <- removes curves
                          ),
                          child: Text("View cart", style: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(45),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text("Checkout", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text('Shop')),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int count = 0;
            if (state is CartInitial) {
              count = state.cartItems.values.fold(0, (sum, q) => sum + q);
            }
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () => _showCartDrawer(context, state),
                ),
                if (count > 0)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text('$count', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            );
          },
        )
      ],
    );
  }
}
