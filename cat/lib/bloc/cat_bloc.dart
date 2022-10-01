import 'dart:io';

import 'package:cat/bloc/cat_event.dart';
import 'package:cat/bloc/cat_state.dart';
import 'package:cat/services/cat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatService service = CatService();

  CatBloc() : super(CatInitial()) {
    on<OpenAppEvent>((event, emit) => {
          service.init(),
        });
    on<CatEvent>(
      (event, emit) async {
        if (event is RequestCatEvent || event is RefreshCatEvent) {
          try {
            emit(LoadingCatState());

            final cat = await service.fetchCat();
            DateTime today = DateTime.now();

            service.addDate(today.toString());

            final getHistory = service.getDates();

            emit(LoadedCatState(
              cat,
              getHistory,
            ));
          } catch (e) {
            emit(FailedCatState(e.toString()));
          }
        }
      },
    );
  }
}
