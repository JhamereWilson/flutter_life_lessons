import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_flutter_life/Services/firebase_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uuid/uuid.dart';

class TestRecord extends StatefulWidget {
  final String topic;
  TestRecord({Key key, this.topic}) : super(key: key);

  @override
  _TestRecordState createState() => _TestRecordState();
}

class _TestRecordState extends State<TestRecord> with TickerProviderStateMixin {
  AnimationController controller;
  final _formKey = GlobalKey<FormState>();

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 180),
    );
  }

  String recordingTitle = "";
  String statusText = "";
  bool isComplete = false;
  bool isRecording = false;
  bool isUploading = false;
  bool isPlaying = false;
  bool isPrivate = false;
  var uuid = Uuid();
  final List<String> entries = <String>[
    'Great',
    'Amazing',
    'Insightful',
    'Touching',
  ];
  final random = Random();
  int index = 0;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      isRecording = true;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;

  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getTemporaryDirectory();
    String sdPath = storageDirectory.path + "/${uuid.v4().toString()}";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  buildRecordCompleteScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Private Lesson?",
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 22, color: Colors.white70),
        ),
        Switch(
          value: isPrivate,
          activeTrackColor: Colors.red,
          activeColor: Colors.white,
          onChanged: (value) {
            setState(() {
              isPrivate = value;
              print(value);
            });
          },
        ),
        Container(
          width: 250,
          child: FlatButton(
            onPressed: () {
              play();
            },
            color: Colors.black26,
            padding: EdgeInsets.all(8.0),
            child: const Text(
              "Listen to Recorded Lesson",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Container(
          width: 250,
          child: FlatButton(
            onPressed: () {
              return Alert(
                context: context,
                title: widget.topic,
                buttons: [
                  DialogButton(
                    child: Text(
                      "Submit Lesson",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      _trySubmit();
                     Navigator.pushReplacementNamed(context, "/root");
                      index = random.nextInt(4);
                      final snackBar = SnackBar(
                        content: Text(
                          ('That was ${entries[index]} 🤗'),
                          // style: kTitleTextStyle,
                          textAlign: TextAlign.center,
                        ),
//            action: SnackBarAction(
//              label: 'Undo',
//              onPressed: () {
//                // Some code to undo the recording.
//              },
//            ),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.green[200],
                        Colors.lightBlue[500],
                      ],
                    ),
                  ),
                ],
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Text("Private or Public Lesson?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),),

                      TextFormField(
                        decoration: InputDecoration(labelText: "Lesson Title"),
                        onSaved: (val) {
                          recordingTitle = val;
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ).show();
            },
            color: Colors.black12,
            padding: EdgeInsets.all(8.0),
            child: const Text(
              "Submit Lesson",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // gets rid of keyboard on submit
    if (isValid) {
      _formKey.currentState.save();
    }
    try {
      if (isPrivate) {
         FirebaseService().privateUpload(
            file: File(recordFilePath),
            topic: widget.topic,
            title: recordingTitle);

      } else {
        FirebaseService().publicUpload(
            file: File(recordFilePath),
            topic: widget.topic,
            title: recordingTitle);
      }
    } on PlatformException catch (err) {
      // Platform Exception throws a Firebase Error =>  "platform"

      var message = "An error occured, please check credentials.";
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  buildRecordIncompleteScreen() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
              child: Text(
                statusText,
                style: TextStyle(fontSize: 28.0, color: Colors.white),
              ),
            ),
          ],
        ),
        isRecording ? stopButton() : recordButton(),
      ],
    );
  }

  Widget recordButton() {
    return Column(
      children: <Widget>[
        ClipOval(
          child: Container(
            width: 70,
            height: 70,
            color: Colors.red,
            child: FlatButton(
              onPressed: () {
                startRecord();
              },
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.mic,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Record",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget stopButton() {
    return Column(
      children: <Widget>[
        ClipOval(
          child: Container(
            width: 70.0,
            height: 70.0,
            color: Colors.red,
            child: FlatButton(
              onPressed: () {
                stopRecord();
              },
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Stop",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  buildRecordScreen() {
    return Material(
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Container(),
                ],
              ),
              Text(
                widget.topic,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SvgPicture.asset('assets/images/purpleMic.svg',
                      height: 300.0, color: Colors.black12)),
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: isComplete
                      ? buildRecordCompleteScreen()
                      : buildRecordIncompleteScreen()),
            ],
          ),
        ),
      ),
    );
  }

  // flutter defined function

  @override
  Widget build(BuildContext context) {
    return buildRecordScreen();
  }
}
