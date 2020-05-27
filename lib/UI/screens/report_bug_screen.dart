import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(BugsOrFeatures());

class BugsOrFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Page',
      home: Scaffold(
          backgroundColor: Color.fromRGBO(75, 234, 255, 0.9),
          appBar: AppBar(
            title: Text('Report a Bug / Request a Lesson'),
          ),
          body: ReportPage(
            title: 'Choose Either One',
          )),
    );
  }
}

class ReportPage extends StatefulWidget {
  ReportPage({Key key, this.title, this.bug, this.feature}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  String bug;
  String bugDescription;
  String feature;
  String featureDescription;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String completed = ('DONE');
  String notCompleted = '';
  bool _submitted = false;
  String _work = '';

  void _feedbackCompleted() {
    setState(() {
      _submitted = true;
      //this is supposed to change the value of _work from an empty string to
      // 'DONE', once _submitted state has been changed to true by FAB(submit)

      _submitted == false ? _work = notCompleted : _work = completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _feedbackCompleted method above.
    //

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              maxLength: 40,
              maxLines: 1,
            
              cursorWidth: 16.0,
             
              
              onChanged: (textB) {
                widget.bug = textB;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Detailed Desciption:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              maxLength: 200,
              maxLines: 8,
             
              onChanged: (textBD) {
                widget.bugDescription = textBD;
              },
            ),
            SizedBox(height: 12, width: 12),
            Text(
              'We appreciate your patience',
              // style: kBodyTextStyle,
            ),
            SizedBox(height: 12, width: 12),
            Text(
              'Thanks for your feedback',
              // style: kBodyTextStyle,
            ),
            SizedBox(height: 24, width: 12),
            Text(
              '$_work',
              // style: kTitleTextStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _feedbackCompleted();

          onSubmitted(ReportPage) {
            // onSubmitted is a callback that retrieves the data from both
            // text fields (widget.bug, widget.bugDescription), and with some
            // code from you, will email us an alert as well a log it into the
            // database for future reference
          }
        },
        child: Text('submit'),
      ),
    );
  }
}