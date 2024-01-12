import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_evaluation/page/paiement_page.dart';
import 'page/page_panier.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => CartPage(),
    ),
    GoRoute(
      path: '/payment',
      builder: (BuildContext context, GoRouterState state) {
        final subtotal = state.extra as double;
        return PaymentPage(subtotal: subtotal);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}