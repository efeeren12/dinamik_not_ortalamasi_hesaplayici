import 'package:dinamik_not_ortalamasi_hesaplayici/constants/app_constants.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/helper/data_helper.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/model/ders.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/widgets/ders_listesi.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(Sabitler.baslikText, style: Sabitler.baslikStyle),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: _buildForm(),
                ),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(dersSayisi: DataHelper.tumEklenenDersler.length, ortalama: DataHelper.ortalamaHesapla()),
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          Expanded(
            // ignore: prefer_const_constructors
            child: DersListesi(
              onDismiss: (index){
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {
                  
                });
              },
            ),
          )
        ],
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: Sabitler.yatayPadding8, child: _buildTextFormField()),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Ders adını giriniz';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Ders Adı',
        labelText: 'Ders Adı',
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100,
      ),
    );
  }

  _buildHarfler() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius,
        ),
        child: DropdownButton<double>(
          value: secilenHarfDegeri,
          onChanged: (deger) {
            setState(() {
              secilenHarfDegeri = deger!;
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinHarfleri(),
        ));
  }

  _buildKrediler() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius,
        ),
        child: DropdownButton<double>(
          value: secilenKrediDegeri,
          onChanged: (deger) {
            setState(() {
              secilenKrediDegeri = deger!;
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinKredileri(),
        ));
  }

  void _dersEkleveOrtalamaHesapla() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var eklenecekDers = Ders(
        ad: girilenDersAdi,
        harfDegeri: secilenHarfDegeri,
        krediDegeri: secilenKrediDegeri);
        DataHelper.dersEkle(eklenecekDers);
        setState(() {});
    }
  }
}
