import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;
  final String email;
  Profile(this.logoutAction, this.name, this.picture, this.email);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen, width: 4.0),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(picture),
                  ),
                ),
              )
            ])),
        SizedBox(height: 24.0),
        Text('$name', style: TextStyle(fontSize: 23)),
        Text('$email @gmail.com', style: TextStyle(fontSize: 23)),
        SizedBox(height: 48.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
