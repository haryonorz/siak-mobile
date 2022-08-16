import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/pages/edit_profile/components/edit_profile_form.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
            const Center(
              child: DefaultUserPhoto(width: 120, height: 120),
            ),
            EditProfileForm(),
          ],
        ),
      ),
    );
  }
}
