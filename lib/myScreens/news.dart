import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatefulWidget {
  @override
  _News createState() => _News();
}

class _MyTestCentersState3 extends State<News> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Test Centers'),
            backgroundColor: Colors.blueAccent,
          ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:
                    'https://news.google.com/topics/CAAqIggKIhxDQkFTRHdvSkwyMHZNREZqY0hsNUVnSmxiaWdBUAE?oc=3&ceid=IN:en',
              )),
        ),
      ),
    );
  }
}

class _News extends State<News> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                initialUrl:
                    'https://news.google.com/topics/CAAqIggKIhxDQkFTRHdvSkwyMHZNREZqY0hsNUVnSmxiaWdBUAE?oc=3&ceid=IN:en',
              )),
          Container(
//            color: Colors.blueAccent,
            height: 75,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Latest Covid-19 News",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      title: Text(
                        "Test Centers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Product Sans',
                        ),
                      ),
                    ),
                  ),*/

//                  Expanded(child: MyFireStore()),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    controller.data.goBack();
                  });
            }

            return Container();
          }),
    );
  }
}

//All the below code is disabled.
class _MyTestCentersState1 extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Go Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      title: Text(
                        "Test Centers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Product Sans',
                        ),
                      ),
                    ),
                  ),

//                  Expanded(child: MyFireStore()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFireStore extends StatefulWidget {
  @override
  _MyFireStoreState createState() => _MyFireStoreState();
}

class _MyFireStoreState extends State<MyFireStore> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("TestCenters")
          .orderBy('state', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: snapshot.data.documents.map(
                (DocumentSnapshot document) {
                  /*if (document['disp'] == true) {
                    return _MyCard(document['title'], document['nav']);
                  }
                  return Container();*/
                  //print(document.documentID);
                  return _MyCard(document['state'], document.documentID);
                },
              ).toList(),
            );
        }
      },
    );
  }
}

class _MyCard extends StatelessWidget {
  final String _str, _nav;
  _MyCard(this._str, this._nav);
  @override
  Widget build(BuildContext context) {
    //_myNav = _nav;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: ListTile(
        title: Text(_str),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InMyState(_str, _nav)));
          print(_nav);
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}

class InMyState extends StatefulWidget {
  final String _inState, _myState;
  InMyState(this._myState, this._inState);
  @override
  _InMyStateState createState() =>
      _InMyStateState(this._myState, this._inState);
}

class _InMyStateState extends State<InMyState> {
  final String _myState, _inState;
  _InMyStateState(this._myState, this._inState);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Go Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      title: Text(
                        "Test Centers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Product Sans',
                        ),
                      ),
                      subtitle: Text(
                        "in $_myState",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(child: InStateDetail(this._inState))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InStateDetail extends StatelessWidget {
  final String _docID;
  InStateDetail(this._docID);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("TestCenters")
          .document('${this._docID}')
          .collection('inState')
          .orderBy('loc', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: snapshot.data.documents.map(
                (DocumentSnapshot document) {
                  return _MyLocCard(document['loc'], document['mapQuery']);
                },
              ).toList(),
            );
        }
      },
    );
  }
}

class _MyLocCard extends StatelessWidget {
  final String _str, _map;
  _MyLocCard(this._str, this._map);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: ListTile(
        title: Text(_str),
        onTap: () async {
          final String url =
              'https://www.google.com/maps/search/?api=1&query=$_map';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
