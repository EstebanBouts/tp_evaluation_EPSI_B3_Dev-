import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  final double subtotal; // Sous-total passé de la page panier

  const PaymentPage({Key? key, required this.subtotal}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = ''; // Méthode de paiement sélectionnée

  double get total => widget.subtotal * 1.2; // Calcul du total avec TVA à 20%

  Widget paymentMethodButton(String method, IconData icon) {
    bool isSelected = selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.red : Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
        ),
        padding: EdgeInsets.all(12),
        child: FaIcon(
          icon,
          size: 36,
          color: isSelected ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalisation de la commande'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Récapitulatif de votre commande', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sous-Total'),
                      Text('${widget.subtotal.toStringAsFixed(2)}€'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vous économisez'),
                      Text('-0.01€'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TVA'),
                      Text('${(widget.subtotal * 0.2).toStringAsFixed(2)}€'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${total.toStringAsFixed(2)}€'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Adresse de livraison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              title: Text('Michel Le Poney', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('8 rue des ouvertures de portes\n93204 CORBEAUX'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Logique pour changer l'adresse
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Méthode de paiement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              paymentMethodButton('apple', FontAwesomeIcons.applePay),
              paymentMethodButton('visa', FontAwesomeIcons.ccVisa),
              paymentMethodButton('paypal', FontAwesomeIcons.paypal),
              paymentMethodButton('mastercard', FontAwesomeIcons.ccMastercard),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'En cliquant sur "Confirmer l\'achat", vous acceptez les Conditions de vente de EPSI Shop International. '
                  'Besoin d\'aide ? Désolé on peut rien faire.\nEn poursuivant, vous acceptez les Conditions d\'utilisation du fournisseur de paiement CoffeeDis.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: selectedPaymentMethod.isNotEmpty ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Votre commande est validée')),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text('Confirmer l\'achat', style: TextStyle(fontSize: 18)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
