import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;

class MyDetail extends StatefulWidget {
  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  String url = 'https://api.rootnet.in/covid19-in/stats/latest';
  var data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      data = jsonDecode(response.body);
    });
    return "";
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Indian States",
            style: TextStyle(fontSize: 20, fontFamily: 'Product Sans'),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Text(
                    "\nLoading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Product Sans'),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        title: Text(
          "Indian States",
          style: TextStyle(fontSize: 20, fontFamily: 'Product Sans'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          ListView.builder(
            itemCount: data == null ? 0 : data['data']['regional'].length,
            itemBuilder: (BuildContext context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          data['data']['regional'][i]['loc'],
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Product Sans'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                                children: [
                                  TextSpan(text: "Total Confirmed Cases :\t"),
                                  TextSpan(
                                      text:
                                          "${int.parse(data['data']['regional'][i]['confirmedCasesIndian'].toString()) + int.parse(data['data']['regional'][i]['confirmedCasesForeign'].toString())}",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "Confirmed Cases (Indian) :\t"),
                                  TextSpan(
                                      text:
                                          "${data['data']['regional'][i]['confirmedCasesIndian'].toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.indigoAccent)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "Confirmed Cases (Foreign) :\t"),
                                  TextSpan(
                                      text:
                                          "${data['data']['regional'][i]['confirmedCasesForeign'].toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepOrangeAccent)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "Discharged :\t"),
                                  TextSpan(
                                      text:
                                          "${data['data']['regional'][i]['discharged'].toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.teal)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                                children: [
                                  TextSpan(text: "Deaths :\t"),
                                  TextSpan(
                                      text:
                                          "${data['data']['regional'][i]['deaths'].toString()}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.redAccent)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10))
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyDetailGlobal extends StatefulWidget {
  @override
  _MyDetailGlobalState createState() => _MyDetailGlobalState();
}

class _MyDetailGlobalState extends State<MyDetailGlobal> {
  String url = 'https://covid2019-api.herokuapp.com/v2/current';
  var data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      data = jsonDecode(response.body);
    });
    return "";
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Text(
                    "\nLoading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Product Sans'),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FlatButton(
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
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data == null ? 0 : data['data'].length,
                    itemBuilder: (BuildContext context, i) {
                      //print(i);
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                trailing: Icon(
                                  Ionicons.md_globe,
                                  size: 40,
                                ),
                                title: Text(
                                  data['data'][i]['location'].toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Product Sans'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(text: "Confirmed Cases :\t"),
                                          TextSpan(
                                            text:
                                                "${data['data'][i]['confirmed'].toString()}",
                                            style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(text: "Deaths :\t"),
                                          TextSpan(
                                            text:
                                                "${data['data'][i]['deaths'].toString()}",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(8))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
