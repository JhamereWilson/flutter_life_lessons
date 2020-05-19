import 'package:firebase_flutter_life/Blocs/recorder_bloc/recorder_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recorder_actions.dart';

class Recorder extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
    color: Colors.white70
  );

  final String recordingTopic;

  const Recorder({this.recordingTopic});

  @override
  Widget build(BuildContext context) {
    final RecorderBloc _recorderBloc = BlocProvider.of<RecorderBloc>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: <Color>[
              Colors.lightGreen[200],
              Colors.lightBlue[600],
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Text(
                recordingTopic,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(
                    child: BlocBuilder(
                      bloc: _recorderBloc,
                      builder: (context, state) {
                        final String minutesStr = ((state.duration / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(1, '0');
                        final String secondsStr = (state.duration % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        return Text(
                          '$minutesStr:$secondsStr',
                          style: Recorder.timerTextStyle,
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<RecorderBloc, RecorderState>(
                  condition: (previousState, state) =>
                      state.runtimeType != previousState.runtimeType,
                  builder: (context, state) => RecorderActions(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
