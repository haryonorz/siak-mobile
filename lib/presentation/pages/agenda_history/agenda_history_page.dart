import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/common/app/app.dart';
import 'package:siak_mobile/presentation/bloc/all_agenda_history/all_agenda_history_bloc.dart';
import 'package:siak_mobile/presentation/widget/agenda_card.dart';
import 'package:siak_mobile/presentation/widget/form/search_form_field.dart';
import 'package:siak_mobile/presentation/widget/view_empty.dart';
import 'package:siak_mobile/presentation/widget/view_error.dart';

class AgendaHistoryPage extends StatefulWidget {
  const AgendaHistoryPage({Key? key}) : super(key: key);

  @override
  State<AgendaHistoryPage> createState() => _AgendaHistoryPageState();
}

class _AgendaHistoryPageState extends State<AgendaHistoryPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AllAgendaHistoryBloc>().add(OnFetchData()));
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
            child: SearchFormField(
              hintText: 'Cari agenda',
              controller: searchController,
              onChanged: (query) {
                context.read<AllAgendaHistoryBloc>().add(OnQueryChanged(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AllAgendaHistoryBloc, AllAgendaHistoryState>(
              builder: (context, state) {
                if (state is AllAgendaHistoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AllAgendaHistoryEmpty) {
                  return ViewEmpty(
                    title: searchController.text.isEmpty
                        ? 'Belum ada agenda yang selesai!'
                        : 'Tidak ada agenda dengan keyword "${searchController.text}"',
                    description:
                        'Jika terdapat agenda yang selesai, silahkan close agenda tersebut.',
                    showRefresh: true,
                    onRefresh: () {
                      if (searchController.text.isEmpty) {
                        context.read<AllAgendaHistoryBloc>().add(OnFetchData());
                      } else {
                        context
                            .read<AllAgendaHistoryBloc>()
                            .add(OnQueryChanged(searchController.text));
                      }
                    },
                  );
                } else if (state is AllAgendaHistoryHasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (searchController.text.isEmpty) {
                        context.read<AllAgendaHistoryBloc>().add(OnFetchData());
                      } else {
                        context
                            .read<AllAgendaHistoryBloc>()
                            .add(OnQueryChanged(searchController.text));
                      }
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
                  return ViewError(
                    message: state.message,
                    showRefresh: true,
                    onRefresh: () {
                      if (searchController.text.isEmpty) {
                        context.read<AllAgendaHistoryBloc>().add(OnFetchData());
                      } else {
                        context
                            .read<AllAgendaHistoryBloc>()
                            .add(OnQueryChanged(searchController.text));
                      }
                    },
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
