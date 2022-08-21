import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/domain/entities/absensi.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/button_student_agenda.dart';
import 'package:siak_mobile/presentation/pages/detail_agenda/components/button_tutor_agenda.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';

class ViewDetaiAgenda extends StatelessWidget {
  final Agenda agenda;
  final int totalRequestJoin;
  final String userType;
  final Absensi? absensi;

  const ViewDetaiAgenda({
    Key? key,
    required this.agenda,
    required this.totalRequestJoin,
    required this.userType,
    this.absensi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDefaults.lSpace),
          Text(
            agenda.pokokBahasan,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: AppDefaults.lSpace),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomField(
                label: "Tutor: ",
                value: agenda.namaTutorPengganti ?? agenda.namaTutor,
                direction: Axis.vertical,
              ),
              const Spacer(),
              const SizedBox(width: AppDefaults.lSpace),
              Text(
                agenda.date.parseDate(
                  fromFormat: "yyyy-MM-dd",
                  toFormat: "EEEE, dd MMM yyyy",
                ),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(height: 14),
          userType == 'tutor'
              ? ButtonTutorAgenda(
                  agenda: agenda, totalRequestJoin: totalRequestJoin)
              : ButtonStudentAgenda(
                  absensi: absensi,
                  userType: userType,
                ),
          const SizedBox(height: AppDefaults.xlSpace),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      label: "Waktu",
                      value: "${agenda.jamIn} - ${agenda.jamOut}",
                      direction: Axis.vertical,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      label: "Ruangan",
                      value: "${agenda.namaCenter}, ${agenda.ruangan}",
                      direction: Axis.vertical,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDefaults.lSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      label: "Kelas",
                      value: "${agenda.namaCenter}, ${agenda.pilKelas}",
                      direction: Axis.vertical,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      label: "Bid. Studi: ",
                      value: agenda.bidangStudi,
                      direction: Axis.vertical,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
