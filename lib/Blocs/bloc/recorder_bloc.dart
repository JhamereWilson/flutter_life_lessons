import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recorder_event.dart';
part 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  @override
  RecorderState get initialState => RecorderInitial();

  @override
  Stream<RecorderState> mapEventToState(
    RecorderEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
