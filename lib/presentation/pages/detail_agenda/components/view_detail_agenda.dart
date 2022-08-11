import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/extensions/string_parsing.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/widget/custom_field.dart';

class ViewDetaiAgenda extends StatelessWidget {
  final Agenda agenda;
  final int totalRequestJoin;

  const ViewDetaiAgenda({
    Key? key,
    required this.agenda,
    required this.totalRequestJoin,
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
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDefaults.mRadius),
                      ),
                    ),
                    child: Text(
                      "Aktifitas Harian".toUpperCase(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDefaults.lSpace),
              agenda.status == '0'
                  ? Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                Routes.requestJoin,
                                arguments: agenda.idAgenda,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.backgroundBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDefaults.mRadius),
                                ),
                                side: const BorderSide(
                                  width: 1.2,
                                  color: AppColors.borderRed,
                                ),
                              ),
                              child: Text(
                                "Permintaan".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(color: AppColors.textRed),
                              ),
                            ),
                          ),
                          totalRequestJoin == 0
                              ? Container()
                              : Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.backgroundRed,
                                        border: Border.all(
                                          color: AppColors.backgroundBlue,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(totalRequestJoin.toString()),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(),
            ],
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
