import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTestCenters extends StatefulWidget {
  @override
  _MyTestCentersState createState() => _MyTestCentersState();
}

class _MyTestCentersState extends State<MyTestCenters> {
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
                  Expanded(child: MyFireStore()),
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
