import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/pages/search/search_cubit/search_states.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) {
    return BlocProvider.of(context);
  }

  late SearchModel model;
// Search method do not need token
  void search({required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      lang: 'en',
      url: SEARCH,
      //token: token,
      data: {
        'text' : text,
      },
    ).then((value) {
       model = SearchModel.fromJson(value.data);
       emit(SearchSuccessState());
    }).catchError((error){
       emit(SearchErrorState());
      print('Error is occurred =>>  ${error.toString()}');
    });
  }
}
