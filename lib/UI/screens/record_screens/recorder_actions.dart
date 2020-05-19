import 'package:firebase_flutter_life/Blocs/recorder_bloc/recorder_barrel.dart';
import 'package:firebase_flutter_life/Services/recorder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecorderActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        recorderBloc: BlocProvider.of<RecorderBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    RecorderBloc recorderBloc,
  }) {
    final RecorderState state = recorderBloc.state;
    if (state is Ready) {
      return [
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 70,
                height: 70,
                color: Colors.red,
                child: FlatButton(
                  onPressed: () {
                    recorderBloc.add(Start(duration: state.duration));
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
        )
      ];
    }
    if (state is Running) {
      return [
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 70,
                height: 70,
                color: Colors.red,
                child: FlatButton(
                  onPressed: () {
                    recorderBloc.add(Pause());
                  },
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.stop,
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
              "Pause Recording",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ];
    }
    if (state is Paused) {
      return [
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 70,
                height: 70,
                color: Colors.red,
                child: FlatButton(
                  onPressed: () {
                    recorderBloc.add(Resume());
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
              height: 20,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.black12,
                        child: FlatButton(
                          onPressed: () {
                            recorderBloc.add(Reset());
                          },
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.replay,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Re-record",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w200,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Column(
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.black12,
                        child: FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Play",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w200,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
    }
    if (state is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.mic),
          onPressed: () => recorderBloc.add(Reset()),
        ),
      ];
    }
    return [];
  }
}
