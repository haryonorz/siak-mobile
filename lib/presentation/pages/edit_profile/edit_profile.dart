import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/user.dart';
import 'package:siak_mobile/presentation/pages/edit_profile/components/edit_profile_form.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class EditProfilePage extends StatelessWidget {
  final User user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Profil'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: UserPhoto(
                width: 120,
                height: 120,
                url: user.foto != '' &&
                        user.foto != 'http://siak.bimbel-strategis.com/uploads/'
                    ? user.foto
                    : '',
              ),
            ),
            EditProfileForm(user: user),
          ],
        ),
      ),
    );
  }
}
