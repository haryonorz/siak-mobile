import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/news.dart';
import 'package:siak_mobile/domain/usecases/get_detail_news.dart';

part 'detail_news_state.dart';

class DetailNewsCubit extends Cubit<DetailNewsState> {
  final GetDetailNews _getDetailNews;

  DetailNewsCubit(this._getDetailNews) : super(DetailNewsInitial());

  void fetchData(String newsId) async {
    emit(DetailNewsLoading());

    final result = await _getDetailNews.execute(newsId);

    result.fold(
      (failure) {
        emit(DetailNewsError(failure.message));
      },
      (news) {
        emit(DetailNewsHasData(news));
      },
    );
  }
}
