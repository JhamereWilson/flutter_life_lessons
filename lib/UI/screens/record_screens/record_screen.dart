import 'package:firebase_flutter_life/Blocs/recorder_bloc/recorder_barrel.dart';
import 'package:firebase_flutter_life/Data/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'record_begin_screen.dart';
import 'recorder.dart';

class RecordScreen extends StatefulWidget {
  static const routeName = '/record-action';
  final String recordingTopic;

  const RecordScreen({this.recordingTopic});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final RecorderBloc _recorderBloc = RecorderBloc(ticker: Ticker());
  @override
  Widget build(BuildContext context) {
    
    return Material(
       child: BlocProvider(
         create: (context) => _recorderBloc,
         child: Recorder(recordingTopic: widget.recordingTopic),
       ),
    );
  }
}