import 'dart:async';
import 'package:firebase_flutter_life/Services/recorder_service.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_flutter_life/Blocs/recorder_bloc/recorder_barrel.dart';
import 'package:firebase_flutter_life/Data/ticker.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  final Ticker _ticker;
  final int _duration = 180;

  StreamSubscription<int> _tickerSubscription;

  RecorderBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  RecorderState get initialState => Ready(_duration);

  @override
  Stream<RecorderState> mapEventToState(
    RecorderEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<RecorderState> _mapStartToState(Start start) async* {
    yield Running(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen(
      (duration) {
        add(Tick(duration: duration));
      },
    );
    RecorderService().startRecord();
  }

  Stream<RecorderState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      RecorderService().pauseRecord();
      yield Paused(state.duration);
    }
  }

  Stream<RecorderState> _mapResumeToState(Resume pause) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      RecorderService().resumeRecord();
      yield Running(state.duration);
    }
  }

  Stream<RecorderState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    RecorderService().stopRecord();
    yield Ready(_duration);
  }

  Stream<RecorderState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished();
  }
}
