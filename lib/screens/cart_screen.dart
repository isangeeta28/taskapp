import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart"), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            if (state.cartItems.isEmpty) return Center(child: Text("Cart is empty"));
            return ListView(
              padding: EdgeInsets.all(8),
              children: state.cartItems.entries.map((e) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Image.network(e.key.fullImageUrl, width: 50),
                    title: Text(e.key.name),
                    subtitle: Text('Qty: ${e.value}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(RemoveFromCart(e.key));
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
