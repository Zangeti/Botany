import 'package:botany/components/loading.dart';
import 'package:botany/services/blogdata.dart';
import 'package:flutter/material.dart';

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
        body: data != null ? Container(child: Text(data)) : Loading());
  }
}
