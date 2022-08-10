import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/cubit/all_agenda_history/all_agenda_history_cubit.dart';
import 'package:siak_mobile/presentation/widget/agenda_card.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';

class AgendaHistoryPage extends StatefulWidget {
  const AgendaHistoryPage({Key? key}) : super(key: key);

  @override
  State<AgendaHistoryPage> createState() => _AgendaHistoryPageState();
}

class _AgendaHistoryPageState extends State<AgendaHistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllAgendaHistoryCubit>().fetchData('all'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Riwayat Agenda'),
        systemOverlayStyle: AppDefaults.statusBarDarkBlue,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDefaults.margin),
            child: const SearchFormField(hintText: 'Cari agenda'),
          ),
          Expanded(
            child: BlocBuilder<AllAgendaHistoryCubit, AllAgendaHistoryState>(
              builder: (context, state) {
                if (state is AllAgendaHistoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AllAgendaHistoryEmpty) {
                  return const Center(
                    child: Text('No Data'),
                  );
                } else if (state is AllAgendaHistoryHasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<AllAgendaHistoryCubit>().fetchData('all');
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final agenda = state.agendas[index];
                        return Container(
                          margin: EdgeInsets.only(
                              top: index == 0 ? AppDefaults.margin : 0,
                              bottom: index == state.agendas.length - 1
                                  ? AppDefaults.margin
                                  : 10),
                          child: AgendaCard(agenda: agenda),
                        );
                      },
                      itemCount: state.agendas.length,
                    ),
                  );
                } else if (state is AllAgendaHistoryError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
