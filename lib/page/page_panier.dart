import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartItem {
  final String title;
  final double price;
  final String imageUrl;

  CartItem({required this.title, required this.price, required this.imageUrl});
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(title: 'Silver Dragon Station Chain Bracelet', price: 695.0, imageUrl: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"),
    CartItem(title: 'Solid Gold Petite Micropave', price: 168.0, imageUrl: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"),
    CartItem(title: 'White Gold Plated Princess', price: 9.99, imageUrl: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg"),
    CartItem(title: 'WD 2TB Elements Portable External Hard Drive - USB 3.0', price: 64.0, imageUrl: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg"),
    CartItem(title: 'SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s', price: 109.0, imageUrl: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg"),
    CartItem(title: 'Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5', price: 109.0, imageUrl: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg"),
    // Ajout d'articles...
  ];

  double get total => cartItems.fold(0, (sum, item) => sum + item.price);

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPSI Shop'),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl, width: 50, height: 50),
                    title: Text(item.title, style: TextStyle(fontSize: 16)),
                    subtitle: Text('${item.price}€', style: TextStyle(color: Colors.red[800], fontSize: 16)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[800]),
                      onPressed: () => removeItem(index),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.red[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Votre panier total est de', style: TextStyle(fontSize: 16)),
                  Text('${total.toStringAsFixed(2)}€', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  var subtotal = total; // Ici, nous utilisons le total calculé comme sous-total
                  GoRouter.of(context).go('/payment', extra: subtotal);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Procéder au paiement', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

