import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  Blog({Key? key}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is blog Page"),
    );
  }
}
