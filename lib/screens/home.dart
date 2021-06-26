import 'package:botany/authentication/profile.dart';
import 'package:botany/screens/blog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String name;
  final String picture;
  final Function logout;
  Home(
      {Key? key,
      required this.name,
      required this.picture,
      required this.logout})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(this.name, this.picture, this.logout);
}

class _HomeState extends State<Home> {
  String name = "";
  String picture = "";
  Function logout;
  _HomeState(this.name, this.picture, this.logout);
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
      Profile(logout, name, picture),
      Profile(logout, name, picture),
      Profile(logout, name, picture),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Botany",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          backgroundColor: Color.fromRGBO(252, 254, 240, 1),
        ),
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color.fromRGBO(252, 254, 240, 1).withOpacity(1),
            ),
            child: Container(
                width: 80,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(252, 254, 240, 1),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Drawer(
                      elevation: 0,
                      child:
                          ListView(padding: EdgeInsets.zero, children: <Widget>[
                        // DrawerHeader(
                        //     child: Text(" "),
                        //     decoration: BoxDecoration(
                        //         border:
                        //             Border.all(width: 0, color: Colors.transparent))),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Color.fromRGBO(252, 254, 240, 1),
                          title:
                              Icon(Icons.home, size: 50, color: Colors.green),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Color.fromRGBO(252, 254, 240, 1),
                          title: Icon(Icons.tv, size: 50, color: Colors.green),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Color.fromRGBO(252, 254, 240, 1),
                          title: Icon(Icons.language,
                              size: 50, color: Colors.green),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Color.fromRGBO(252, 254, 240, 1),
                          title:
                              Icon(Icons.person, size: 50, color: Colors.green),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                    )))),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.tv,
              ),
              label: 'Studio',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.language,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
