import 'dart:convert';

import 'package:botany/components/loading.dart';
import 'package:botany/services/blogdata.dart';
import 'package:flutter/material.dart';

import 'plantInterface.dart';

class Encyclopedia extends StatefulWidget {
  Encyclopedia({Key? key}) : super(key: key);

  @override
  _EncyclopediaState createState() => _EncyclopediaState();
}

class _EncyclopediaState extends State<Encyclopedia> {
  BlogData blogdata = BlogData();
  var data;

  @override
  void initState() {
    blogdata.fetchencyclypedia().then((value) {
      setState(() {
        data = value.body;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    if (data != null) {
      dynamic formattedData = jsonDecode(data);
      for(int i = 0; i < formattedData.length; i++) {
        widgetList.add(
          Card(
            color: (i%2 == 0 ? Colors.green : Colors.greenAccent),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlantSpecificScreen(formattedData[i]))
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formattedData[i]["Name"].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87
                            ),
                          )
                        )
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child:Text(
                            formattedData[i]["alternateName"].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54
                            ),
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
          )
        );
      }
    } else {
      widgetList.add(Loading());
    }

    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.green),
            title: Text(
              "Encyclopedia",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            backgroundColor: Color.fromRGBO(252, 254, 240, 1)),
        body: SingleChildScrollView(
          child: Column(
            children: widgetList
          )
        )
      );
  }
}
