import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/data/datasources/remote/network/endpoints.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';
import 'package:siak_mobile/presentation/widget/default_user_photo.dart';
import 'package:siak_mobile/presentation/widget/user_photo.dart';

class AgendaCard extends StatelessWidget {
  final Agenda agenda;

  const AgendaCard({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalStudent = agenda.totalStudent ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detailAgenda,
          arguments: agenda.idAgenda,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.lRadius),
                ),
                color: AppColors.backgroundLightBlue,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agenda.date.parseDate(
                          fromFormat: "yyyy-MM-dd",
                          toFormat: "EEEE, dd MMM yyyy",
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      CustomField(
                        label: "Kelas",
                        value: "${agenda.namaCenter},",
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      Text(
                        agenda.pilKelas,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      CustomField(
                        label: "Waktu",
                        value: "${agenda.jamIn} - ${agenda.jamOut}",
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      CustomField(
                        label: "Ruangan",
                        value: agenda.ruangan,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agenda.pokokBahasan,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: AppDefaults.sSpace),
                    CustomField(
                      label: "Bid. Studi: ",
                      value: agenda.bidangStudi,
                    ),
                    const SizedBox(height: AppDefaults.sSpace),
                    CustomField(
                      label: "Tutor: ",
                      value: agenda.namaTutorPengganti ?? agenda.namaTutor,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: Stack(
                        children: agenda.allStudent.map((student) {
                          int index = agenda.allStudent.indexOf(student);
                          if (index < 3) {
                            return Positioned(
                              left: index * 26,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.backgroundBlue,
                                    ),
                                    color: AppColors.backgroundLightGrey),
                                child: student.fotoAbsen != null
                                    ? UserPhoto(
                                        width: 34,
                                        height: 34,
                                        url:
                                            '${EndPoints.baseUrlPhoto}/absen/${student.fotoAbsen}',
                                      )
                                    : const DefaultUserPhoto(
                                        width: 34,
                                        height: 34,
                                      ),
                              ),
                            );
                          } else if (index == 3) {
                            return Positioned(
                              left: index * 26,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.backgroundBlue,
                                  ),
                                  color: AppColors.backgroundRed,
                                ),
                                child: Center(
                                  child: Text(
                                    "+${totalStudent - 3}",
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
