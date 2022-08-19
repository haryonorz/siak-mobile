import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/presentation/cubit/profile/profile_cubit.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({Key? key}) : super(key: key);

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileCubit>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileHasData) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.nama,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      CustomField(
                        label: state.user.type == "tutor"
                            ? "Kode Tutor: "
                            : "No Siswa: ",
                        value: state.user.username,
                        valueStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 2),
                      CustomField(
                        label: "No Hp: ",
                        value: state.user.noHp,
                        valueStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 2),
                      state.user.type == "tutor"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomField(
                                  label: "Kelas: ",
                                  value: '-',
                                  valueStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                ),
                                const SizedBox(height: 2),
                                CustomField(
                                  label: "Mata Pelajaran: ",
                                  value: '-',
                                  valueStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(width: AppDefaults.lSpace),
                Column(
                  children: [
                    state.user.foto != ''
                        ? UserPhoto(
                            width: 80,
                            height: 80,
                            url:
                                '${EndPoints.baseUrlPhoto}/profile/${state.user.foto}',
                          )
                        : const DefaultUserPhoto(width: 80, height: 80),
                    const SizedBox(height: AppDefaults.lSpace),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.editProfile,
                        arguments: state.user,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(90, 38),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDefaults.mRadius),
                        ),
                      ),
                      child: const Text("Edit Profil"),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is ProfileError) {
            return ViewError(
              message: state.message,
              showRefresh: true,
              onRefresh: () {
                context.read<ProfileCubit>().fetchData();
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
