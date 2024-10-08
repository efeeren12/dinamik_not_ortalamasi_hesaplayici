import 'package:dinamik_not_ortalamasi_hesaplayici/constants/app_constants.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/helper/data_helper.dart';
import 'package:dinamik_not_ortalamasi_hesaplayici/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onDismiss;
  const DersListesi({required this.onDismiss, super.key});

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.isNotEmpty
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onDismiss(index);
                },
                key: UniqueKey(),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text(
                          (tumDersler[index].harfDegeri *
                                  tumDersler[index].krediDegeri)
                              .toStringAsFixed(0),
                        ),
                      ),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} Kredi  Not Değeri: ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            })
        // ignore: avoid_unnecessary_containers
        : Container(
            child: Center(
              child: Text(
                'Lütfen ders ekleyin',
                style: Sabitler.baslikStyle,
              ),
            ),
          );
  }
}
