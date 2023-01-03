import 'package:flutter/material.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/widget/shimmer/loading_attendance_student.dart';

class LoadingDetailAgenda extends StatelessWidget {
  const LoadingDetailAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppDefaults.lSpace),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.xlSpace),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.sSpace),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 100,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: AppDefaults.xlSpace),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
              ),
              const SizedBox(height: AppDefaults.xlSpace),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.sSpace),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.sSpace),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.sSpace),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.lSpace),
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDefaults.sSpace),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDefaults.xlSpace),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
          ),
          child: Container(
            width: 100,
            height: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppDefaults.sSpace),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppDefaults.padding),
            child: ListView.separated(
              itemBuilder: (_, __) => const LoadingAttendanceStudent(),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: 3,
            ),
          ),
        ),
      ],
    );
  }
}
