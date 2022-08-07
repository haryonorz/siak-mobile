import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/domain/entities/student.dart';

class AgendaCard extends StatelessWidget {
  final Agenda agenda;

  const AgendaCard({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
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
                      "Senin, 01 Aug 2022",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDefaults.lSpace),
                    Text(
                      "Kelas",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${agenda.center},",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDefaults.lSpace),
                    Text(
                      agenda.pilKelas,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: AppDefaults.lSpace),
                    Text(
                      "Waktu",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${agenda.jamIn} - ${agenda.jamOut}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDefaults.lSpace),
                    Text(
                      "Ruangan",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      agenda.ruangan,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
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
                  Text(
                    "Bid. Studi: ",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    agenda.bidangStudi,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppDefaults.sSpace),
                  Text(
                    "Tutor: ",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    agenda.tutorPengganti == ''
                        ? agenda.tutor
                        : agenda.tutorPengganti,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                              ),
                              child: Image.asset(
                                AppImages.defaultPhoto,
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
                                  "+${agenda.totalStudent - 3}",
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
    );
  }
}
