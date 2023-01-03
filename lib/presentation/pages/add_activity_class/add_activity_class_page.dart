import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/domain/entities/agenda.dart';
import 'package:siak_mobile/presentation/cubit/action_activity_class/action_activity_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_activity_class/info_activity_class_cubit.dart';
import 'package:siak_mobile/presentation/pages/add_activity_class/components/add_activity_class_form.dart';

class AddActivityClassPage extends StatefulWidget {
  final Agenda agenda;

  const AddActivityClassPage({
    Key? key,
    required this.agenda,
  }) : super(key: key);

  @override
  State<AddActivityClassPage> createState() => _AddActivityClassPageState();
}

class _AddActivityClassPageState extends State<AddActivityClassPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<InfoActivityClassCubit>().fetchData(widget.agenda));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionActivityClassCubit, ActionActivityClassState>(
      listener: (context, state) {
        if (state is ActionActivityClassSuccess) {
          Navigator.pop(context);
        }
        if (state is ActionActivityClassError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textWhite),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDefaults.sRadius)),
              elevation: 0,
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Aktifitas Harian'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<InfoActivityClassCubit>().fetchData(widget.agenda);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              if (widget.agenda.status == '0')
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: BlocBuilder<InfoActivityClassCubit,
                      InfoActivityClassState>(
                    builder: (context, state) {
                      if (state is InfoActivityClassLoading) {
                        return Shimmer.fromColors(
                          baseColor: AppColors.baseColor,
                          highlightColor: AppColors.highlightColor,
                          enabled: true,
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            color: Colors.white,
                          ),
                        );
                      } else if (state is InfoActivityClassHasData) {
                        return Material(
                          color: AppColors.backgroundLightBlue,
                          borderRadius:
                              BorderRadius.circular(AppDefaults.sRadius),
                          child: ListTile(
                            leading: const Icon(Icons.info_outline_rounded),
                            title: Text(
                                'Aktifitas kelas hanya bisa di tambahkan sampai ${state.inputDuration} setelah agenda kelas dimulai.'),
                            dense: true,
                            minLeadingWidth: 10,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              else
                Container(),
              AddActivityClassForm(
                agenda: widget.agenda,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
