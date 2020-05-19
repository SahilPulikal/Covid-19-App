import 'package:covid_19/myScreens/myAssesment.dart';
import 'package:covid_19/myScreens/myInfo.dart';
import 'package:covid_19/myScreens/testCenters.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'myScreens/myHelp.dart';
import 'myScreens/HomePage.dart';
import 'myScreens/myStats.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'myScreens/myStatsDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application Hi.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
        '/detail': (context) => MyDetail(),
        '/stats': (context) => MyStatsScaffold(),
        '/globe': (context) => MyStatsGlobal(),
        '/globeDetail': (context) => MyDetailGlobal(),
        '/MoreHelplines': (context) => MoreHelplines(),
        '/TestCenters': (context) => MyTestCenters(),
        '/ques1': (context) => Ques1(),
        '/ques2': (context) => Ques2(),
        '/ques3': (context) => Ques3(),
        '/ques4': (context) => Ques4(),
        '/ques5': (context) => Ques5(),
        '/ques6': (context) => Ques6(),
        '/ques7': (context) => Ques7(),
        '/quesResult': (context) => QuesResult(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePage _homePage = new HomePage();
  final MyStats _myStats = new MyStats();
  final MyHelp _myHelp = new MyHelp();
  final MyAssesment _myAssesment = new MyAssesment();
  final MyInfo _myInfo = new MyInfo();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homePage;
        break;
      case 1:
        return _myStats;
        break;
      case 2:
        return _myAssesment;
        break;
      case 3:
        return _myInfo;
        break;
      case 4:
        return _myHelp;
        break;
      default:
        return new Container(
          color: Colors.blueAccent,
          child: Center(
            child: ListTile(
              title: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 50,
              ),
              subtitle: Text(
                "\nEmpty Page",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.format_list_bulleted, size: 30),
          Icon(FontAwesome.user_md, size: 30),
          Icon(Icons.info_outline, size: 30),
          Icon(Icons.help_outline, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 350),
        onTap: (int index) {
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
      body: _showPage,
    );
  }
}

class MyLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              Text(
                "\nLoading..",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
