import 'package:dinamik_not_ortalamasi_hesaplayici/constants/app_constants.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/widgets/ortalama_hesapla_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dinamik Ortalama Hesapla',
      theme: ThemeData(
        primarySwatch: Sabitler.anaRenk,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OrtalamaHesaplaPage(),
    );
  }
}
