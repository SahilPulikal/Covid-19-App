import 'dart:convert';
import 'package:covid_19/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHelp extends StatefulWidget {
  @override
  _MyHelpState createState() => _MyHelpState();
}

class _MyHelpState extends State<MyHelp> {
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
                0.7,
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 18),
            child: ListView(
              children: <Widget>[
                //Add list here
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: ListTile(
                    title: Text(
                      "Need Help ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Product Sans',
                      ),
                    ),
                    subtitle: Text(
                      "Helplines...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Product Sans',
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                NearHospital(),
                Padding(padding: EdgeInsets.all(5)),
                MoHW(),
                Padding(padding: EdgeInsets.all(5)),
                AllMyTestCenters(),
                Padding(padding: EdgeInsets.all(5)),
                Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                    title: Text(
                      "More helplines",
                      style: TextStyle(
//            fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Product Sans',
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.pushNamed(context, '/MoreHelplines'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      size: 30,
                    ),
                    title: Text(
                      "FAQs",
                      style: TextStyle(
//            fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Product Sans',
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      const url = 'https://www.mohfw.gov.in/pdf/FAQ.pdf';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
//                Padding(padding: EdgeInsets.all(5)),
//                About(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Product Sans'),
                      children: [
                        TextSpan(text: "Designed and Developed with ❤ by\t"),
                        TextSpan(
                          text:
                              "\nStudents at KC College of Engineering,Thane(E)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // TextSpan(text: "\t&\t"),
                        // TextSpan(
                        //   text: "Sahil Pulikal",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NearHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(
          MaterialCommunityIcons.google_maps,
          size: 30,
        ),
        title: Text(
          "Visit nearest Hospital",
          style: TextStyle(fontFamily: 'Product Sans', fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          const url =
              'https://www.google.com/maps/search/?api=1&query=hospitals+near+me';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}

class MoHW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              "Ministry of Health & Family Welfare",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                fontFamily: 'Product Sans',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: Icon(
                Entypo.old_phone,
                size: 28,
              ),
              title: Row(
                children: <Widget>[
                  Text(
                    "Call ",
                    style: TextStyle(fontFamily: 'Product Sans'),
                  ),
                  Text(
                    "1075",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Product Sans'),
                  ),
                ],
              ),
              subtitle: Text("Toll-free Number"),
              onTap: () async {
                const call = 'tel:1075';
                if (await canLaunch(call)) {
                  await launch(call);
                } else {
                  throw 'Could not launch $call';
                }
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: Icon(
                Ionicons.ios_call,
                size: 30,
              ),
              title: Text("Helpline Number",
                  style: TextStyle(fontFamily: 'Product Sans')),
              subtitle: Text(
                "+91-11-23978046",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: 'Product Sans'),
              ),
              onTap: () async {
                const phoneNo = 'tel:+91-11-23978046';
                if (await canLaunch(phoneNo)) {
                  await launch(phoneNo);
                } else {
                  throw 'Could not launch $phoneNo';
                }
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: Icon(
                Entypo.mail,
                size: 28,
              ),
              title: Text("Helpline Email ID",
                  style: TextStyle(fontFamily: 'Product Sans')),
              subtitle: Text(
                "ncov2019@gov.in",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: 'Product Sans'),
              ),
              onTap: () async {
                const mailTo =
                    'mailto:ncov2019@gov.in?subject=COVID-19%20Regd.';
                if (await canLaunch(mailTo)) {
                  await launch(mailTo);
                } else {
                  throw 'Could not launch $mailTo';
                }
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreHelplines extends StatefulWidget {
  @override
  _MoreHelplinesState createState() => _MoreHelplinesState();
}

class _MoreHelplinesState extends State<MoreHelplines> {
  String url = 'https://api.rootnet.in/covid19-in/contacts';
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
      return MyLoadingScreen();
    }
    return Scaffold(
      body: Stack(
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
                  0.9
                ],
                    colors: [
                  Colors.purple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.cyan,
                  Colors.blueAccent
//                Colors.teal,
                ])),
//            color: Colors.blueAccent,
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
                    itemCount: data == null
                        ? 0
                        : data['data']['contacts']['regional'].length,
                    itemBuilder: (BuildContext context, i) {
                      //print(data['data']['contacts']['regional'][i].length);
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Icon(
                            Ionicons.ios_call,
                            size: 30,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text(
                            "${data['data']['contacts']['regional'][i]['loc'].toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Product Sans',
                            ),
                          ),
                          subtitle: Text(
                            "${data['data']['contacts']['regional'][i]['number'].toString().split(',')[0]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Product Sans',
                            ),
                          ),
                          onTap: () async {
                            String phoneNo =
                                'tel:${data['data']['contacts']['regional'][i]['number'].toString().split(',')[0]}';
                            if (await canLaunch(phoneNo)) {
                              await launch(phoneNo);
                            } else {
                              throw 'Could not launch $phoneNo';
                            }
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllMyTestCenters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(
          MaterialCommunityIcons.hospital_building,
          size: 30,
        ),
        title: Text(
          "Test Centers",
          style: TextStyle(
//            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'Product Sans',
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.pushNamed(context, '/TestCenters'),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(
          MaterialCommunityIcons.information,
          size: 30,
        ),
        title: Text(
          "About",
          style: TextStyle(
//            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'Product Sans',
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.pushNamed(context, '/TestCenters'),
      ),
    );
  }
}
