import 'package:equatable/equatable.dart';

abstract class RecorderState extends Equatable {
  final int duration;

  const RecorderState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Ready extends RecorderState {
  const Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends RecorderState {
  const Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends RecorderState {
  const Running(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends RecorderState {
  const Finished() : super(0);
}
