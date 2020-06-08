import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.1,
                0.2,
                0.4,
                0.6,
                0.8
              ],
                  colors: [
                Colors.purple,
                Colors.indigo,
                Colors.blue,
                Colors.cyan,
                Colors.blueAccent
//                Colors.teal,
              ])),
//          color: Colors.blueAccent,
        ),
        SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                /*padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6, left: 20),*/
                padding: EdgeInsets.only(top: 50, left: 20),
                child: ListTile(
                  title: Text(
                    "Hello",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    "How are you feeling today ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Product Sans',
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    children: [
                      TextSpan(text: "This "),
                      TextSpan(
                          text: "COVID-19 App",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      TextSpan(
                          text:
                              " will help you stay updated with the current Corona virus count in India and across the world. It also includes a self-assessment with helplines and test centers in each state and basic preventive measures"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(20)),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15,
                      color: Colors.white,
                      onPressed: () => Navigator.pushNamed(context, '/News'),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Covid-19 News",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                              fontFamily: 'Product Sans'),
                        ),
                      ),
                    ),
//                    StreamBuilder<QuerySnapshot>(
//                      stream: Firestore.instance
//                          .collection("myCarousel")
//                          .snapshots(),
//                      builder: (BuildContext context,
//                          AsyncSnapshot<QuerySnapshot> snapshot) {
//                        if (snapshot.hasError)
//                          return new Text('Error: ${snapshot.error}');
//                        switch (snapshot.connectionState) {
//                          case ConnectionState.waiting:
//                            return Center(
//                              child: CircularProgressIndicator(),
//                            );
//                          default:
//                            return new CarouselSlider(
//                              autoPlayAnimationDuration:
//                                  Duration(milliseconds: 900),
//                              autoPlay: true,
//                              pauseAutoPlayOnTouch: Duration(seconds: 3),
//                              height: 150,
//                              enlargeCenterPage: true,
//                              items: snapshot.data.documents.map(
//                                (DocumentSnapshot document) {
//                                  if (document['type']
//                                          .toString()
//                                          .compareTo('inlink') ==
//                                      0) {
//                                    return _MyCarouselBodyInlink(
//                                        document['tf      itle'],
//                                        document['subtitle'],
//                                        document['button'],
//                                        document['nav']);
//                                  } else if (document['type']
//                                          .toString()
//                                          .compareTo('outlink') ==
//                                      0) {
//                                    return _MyCarouselBodyOutlink(
//                                        document['title'],
//                                        document['subtitle'],
//                                        document['button'],
//                                        document['nav']);
//                                  } else if (document['type']
//                                          .toString()
//                                          .compareTo('nolink') ==
//                                      0) {
//                                    return null;
//                                  }
//                                  return null;
//                                },
//                              ).toList(),
//                            );
//                        }
//                      },
//                    ),
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MyCarouselBodyInlink extends StatelessWidget {
  final String _title, _subtitle, _buttonText, _nav;
  _MyCarouselBodyInlink(
      this._title, this._subtitle, this._buttonText, this._nav);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(_title),
                subtitle: Text(_subtitle),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.blueAccent,
                      child: Text(
                        _buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pushNamed(context, _nav),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyCarouselBodyOutlink extends StatelessWidget {
  final String _title, _subtitle, _buttonText, _nav;
  _MyCarouselBodyOutlink(
      this._title, this._subtitle, this._buttonText, this._nav);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(_title),
                subtitle: Text(_subtitle),
                //onTap: ()=>print("object"),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.blueAccent,
                      child: Text(
                        _buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final String url = '$_nav';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
