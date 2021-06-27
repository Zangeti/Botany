import 'package:botany/authentication/profile.dart';
import 'package:botany/screens/blog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String name;
  final String picture;
  final Function logout;
  final String email;
  Home(
      {Key? key,
      required this.name,
      required this.picture,
      required this.logout,
      required this.email})
      : super(key: key);

  @override
  _HomeState createState() =>
      _HomeState(this.name, this.picture, this.logout, this.email);
}

class _HomeState extends State<Home> {
  String name = "";
  String picture = "";
  Function logout;
  String email = "";
  _HomeState(this.name, this.picture, this.logout, this.email);
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Blog(),
      Profile(logout, name, picture, email),
      Profile(logout, name, picture, email),
      Profile(logout, name, picture, email),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: Container(
              child: IconButton(
            icon: Icon(Icons.book_rounded),
            onPressed: () {
              // Navigator.push(context, route)
            },
          )),
          title: Text(
            "Botany",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          backgroundColor: Color.fromRGBO(252, 254, 240, 1),
        ),
        // drawer: Theme(
        //     data: Theme.of(context).copyWith(
        //       canvasColor: Color.fromRGBO(252, 254, 240, 1).withOpacity(1),
        //     ),
        //     child: Container(
        //         width: 80,
        //         height: 250,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20),
        //           color: Color.fromRGBO(252, 254, 240, 1),
        //         ),
        //         child: ClipRRect(
        //             borderRadius: BorderRadius.circular(20),
        //             child: Drawer(
        //               elevation: 0,
        //               child:
        //                   ListView(padding: EdgeInsets.zero, children: <Widget>[
        //                 // DrawerHeader(
        //                 //     child: Text(" "),
        //                 //     decoration: BoxDecoration(
        //                 //         border:
        //                 //             Border.all(width: 0, color: Colors.transparent))),
        //                 ListTile(
        //                   contentPadding: EdgeInsets.all(0),
        //                   tileColor: Color.fromRGBO(252, 254, 240, 1),
        //                   title:
        //                       Icon(Icons.home, size: 50, color: Colors.green),
        //                   onTap: () {
        //                     Navigator.pop(context);
        //                   },
        //                 ),
        //                 ListTile(
        //                   contentPadding: EdgeInsets.all(0),
        //                   tileColor: Color.fromRGBO(252, 254, 240, 1),
        //                   title: Icon(Icons.tv, size: 50, color: Colors.green),
        //                   onTap: () {
        //                     Navigator.pop(context);
        //                   },
        //                 ),
        //                 ListTile(
        //                   contentPadding: EdgeInsets.all(0),
        //                   tileColor: Color.fromRGBO(252, 254, 240, 1),
        //                   title: Icon(Icons.language,
        //                       size: 50, color: Colors.green),
        //                   onTap: () {
        //                     Navigator.pop(context);
        //                   },
        //                 ),
        //                 ListTile(
        //                   contentPadding: EdgeInsets.all(0),
        //                   tileColor: Color.fromRGBO(252, 254, 240, 1),
        //                   title:
        //                       Icon(Icons.person, size: 50, color: Colors.green),
        //                   onTap: () {
        //                     Navigator.pop(context);
        //                   },
        //                 ),
        //               ]),
        //             )))),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.library_books,
              ),
              label: 'Reference',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.shop,
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
