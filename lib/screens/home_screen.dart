import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_bloc.dart';
import '../widgets/app_header.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.0 : 190.0),
          child: AppHeader(),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Showing 1-${products.length} of ${products.length}",
                                style: TextStyle(fontSize: 14, color: Colors.black87)),
                            Row(
                              children: [
                                Text("Sort by: ", style: TextStyle(fontSize: 14)),
                                SizedBox(width: 6),
                                DropdownButton<String>(
                                  value: "Default",
                                  items: [
                                    DropdownMenuItem(value: "Default", child: Text("Default")),
                                    DropdownMenuItem(value: "Price", child: Text("Price")),
                                  ],
                                  onChanged: (val) {},
                                  underline: SizedBox(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 2 : 3,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: isMobile ? 10 : 20,
                          mainAxisSpacing: isMobile ? 10 : 0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

