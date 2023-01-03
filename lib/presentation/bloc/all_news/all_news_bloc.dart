import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:siak_mobile/domain/entities/news.dart';
import 'package:siak_mobile/domain/usecases/get_all_news.dart';

part 'all_news_state.dart';
part 'all_news_event.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  final GetAllNews _getAllNews;

  AllNewsBloc(
    this._getAllNews,
  ) : super(const AllNewsState()) {
    on<OnFetchData>(
      _onFetchData,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
  }

  Future<void> _onFetchData(
    OnFetchData event,
    Emitter<AllNewsState> emit,
  ) async {
    if (state.hasReachedMax && !event.isRefresh) return;
    try {
      if (event.isRefresh || state.status == AllNewsStatus.initial) {
        final result = await _getAllNews.execute();

        result.fold(
          (failure) {
            return emit(
              state.copyWith(
                status: AllNewsStatus.failure,
                errorMessage: failure.message,
              ),
            );
          },
          (news) {
            return emit(
              state.copyWith(
                status: AllNewsStatus.success,
                news: news,
                hasReachedMax: false,
              ),
            );
          },
        );
      }
      final result = await _getAllNews.execute(page: state.news.length);

      result.fold(
        (failure) {
          return emit(
            state.copyWith(
              status: AllNewsStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (agendas) {
          agendas.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: AllNewsStatus.success,
                    news: List.of(state.news)..addAll(agendas),
                    hasReachedMax: false,
                  ),
                );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllNewsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
