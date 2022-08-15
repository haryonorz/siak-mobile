import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/action_situation_class/action_situation_class_cubit.dart';
import 'package:siak_mobile/presentation/cubit/info_problem_class/info_problem_class_cubit.dart';
import 'package:siak_mobile/presentation/pages/add_situation_class/components/add_situation_class_form.dart';

class AddSituationClassPage extends StatefulWidget {
  final String idAgenda;

  const AddSituationClassPage({
    Key? key,
    required this.idAgenda,
  }) : super(key: key);

  @override
  State<AddSituationClassPage> createState() => _AddSituationClassPageState();
}

class _AddSituationClassPageState extends State<AddSituationClassPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<InfoProblemClassCubit>().fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionSituationClassCubit, ActionSituationClassState>(
      listener: (context, state) {
        if (state is ActionSituationClassSuccess) {
          Navigator.pop(context);
        }
        if (state is ActionSituationClassError) {
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
          title: const Text('Tambah Potret Kelas'),
          systemOverlayStyle: AppDefaults.statusBarDarkBlue,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<InfoProblemClassCubit>().fetchData();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: AppDefaults.lSpace),
              BlocBuilder<InfoProblemClassCubit, InfoProblemClassState>(
                builder: (context, state) {
                  if (state is InfoProblemClassLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is InfoProblemClassHasData) {
                    return Material(
                      color: AppColors.backgroundLightBlue,
                      borderRadius: BorderRadius.circular(AppDefaults.sRadius),
                      child: ListTile(
                        leading: const Icon(Icons.info_outline_rounded),
                        title: Text(
                            'Potret kelas hanya bisa di tambahkan, ${state.inputDuration} setelah agenda kelas selesai.'),
                        dense: true,
                        minLeadingWidth: 10,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: AppDefaults.xlSpace),
              AddSituationClassForm(
                idAgenda: widget.idAgenda,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
