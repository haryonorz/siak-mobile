import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/pages/add_situation_class/components/add_situation_class_form.dart';

class AddSituationClassPage extends StatelessWidget {
  final String idAgenda;

  const AddSituationClassPage({
    Key? key,
    required this.idAgenda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tambah Potret Kelas'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
        child: Column(
          children: [
            const SizedBox(height: AppDefaults.lSpace),
            Material(
              color: AppColors.backgroundLightBlue,
              borderRadius: BorderRadius.circular(AppDefaults.sRadius),
              child: const ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title: Text(
                    'Potret kelas hanya bisa di tambahkan, 2 jam setelah agenda kelas selesai.'),
                dense: true,
                minLeadingWidth: 10,
              ),
            ),
            const SizedBox(height: AppDefaults.xlSpace),
            AddSituationClassForm(),
          ],
        ),
      ),
    );
  }
}
