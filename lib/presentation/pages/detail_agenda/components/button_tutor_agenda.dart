import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/common/routes.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';

class ButtonTutorAgenda extends StatelessWidget {
  final Agenda agenda;
  final int totalRequestJoin;

  const ButtonTutorAgenda({
    Key? key,
    required this.agenda,
    required this.totalRequestJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.addActivityClass,
                arguments: agenda,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.mRadius),
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
                          backgroundColor: AppColors.backgroundBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDefaults.mRadius),
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
    );
  }
}
