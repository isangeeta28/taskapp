import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

abstract class CartState {}

class CartInitial extends CartState {
  final Map<Product, int> cartItems;
  CartInitial(this.cartItems);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  Map<Product, int> cartItems = {};

  CartBloc() : super(CartInitial({})) {
    on<AddToCart>((event, emit) {
      if (cartItems.containsKey(event.product)) {
        cartItems[event.product] = cartItems[event.product]! + 1;
      } else {
        cartItems[event.product] = 1;
      }
      emit(CartInitial(Map.from(cartItems)));
    });

    on<RemoveFromCart>((event, emit) {
      if (cartItems.containsKey(event.product)) {
        if (cartItems[event.product]! > 1) {
          cartItems[event.product] = cartItems[event.product]! - 1;
        } else {
          cartItems.remove(event.product);
        }
      }
      emit(CartInitial(Map.from(cartItems)));
    });
  }
}
