import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RecorderEvent extends Equatable {
  const RecorderEvent();
}

class Start extends RecorderEvent {
  final int duration;

  const Start({@required this.duration});

  @override
  String toString() => "Start { duration: $duration }";

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class Pause extends RecorderEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Resume extends RecorderEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Reset extends RecorderEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Tick extends RecorderEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}
