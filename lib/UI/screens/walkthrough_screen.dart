import 'package:firebase_flutter_life/Models/walkthrough_model.dart';
import 'package:firebase_flutter_life/UI/widgets/Buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import "package:flutter_swiper/flutter_swiper.dart";
import 'package:shared_preferences/shared_preferences.dart';

class WalkthroughScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final List<Walkthrough> pages = [
    Walkthrough(
      icon: Icons.headset,
      title: "Listen",
      description:
          'When you have more questions than answers, listen to what’s "tried and true" to help make sense of it all.',
    ),
    Walkthrough(
      icon: Icons.mic,
      title: "Share",
      description:
          "Share wisdom and perspectives, eternally saved, making sure that guiding light shines for generations to come.",
    ),
    Walkthrough(
      icon: Icons.library_books,
      title: "Learn",
      description:
          "Learn from others like yourself, who’ve turned pain into power, by sharing their trials and tribulations with the Life Lessons Community. Now you too, by empowering others, can free yourself from the burdens of the past, in just a few seconds…",
    ),
  ];

  WalkthroughScreen({this.prefs});

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        autoplay: false,
        index: 0,
        loop: false,
        pagination: SwiperPagination(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white30,
              activeColor: Colors.white,
              size: 6.5,
              activeSize: 8.0),
        ),
        control: SwiperControl(
          iconPrevious: null,
          iconNext: null,
        ),
        children: _getPages(context),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.pages.length; i++) {
      Walkthrough page = widget.pages[i];
      widgets.add(
        Container(
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
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Icon(page.icon, size: 125.0, color: Colors.black12),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  page.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  page.description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: page.extraWidget,
              )
            ],
          ),
        ),
      );
    }
    widgets.add(
      Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 250,
              width: 250,
              child: Center(
                child: Text(
                  "life lessons",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    // fontFamily: "OpenSans",
                  ),
                ),
              ),
            ),
            //life lessons logo section

            SizedBox(
              height: 60,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
              child: CustomFlatButton(
                title: "Get Started",
                fontSize: 22,
                fontWeight: FontWeight.w300,
                textColor: Colors.white,
                onPressed: () {
                  // widget.prefs.setBool('seen', true);
                  Navigator.of(context).pushReplacementNamed('/register-screen');
                },
                splashColor: Colors.black12,
                borderColor: Colors.white,
                borderWidth: 1,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
    return widgets;
  }
}
