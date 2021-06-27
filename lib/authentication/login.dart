import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(252, 254, 240, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment(-1, -1),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: AssetImage('assets/plant.jpg'),
                      fit: BoxFit.fitHeight)),
            ),
            Container(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    loginAction();
                  },
                  child: Text('Login'),
                )),
            Text(
              "Login to continue",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}
