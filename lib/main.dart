import 'package:botany/authentication/login.dart';
import 'package:botany/authentication/profile.dart';
import 'package:botany/components/loading.dart';
import 'package:botany/screens/home.dart';
import 'package:flutter/material.dart';

// Auth0 related packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

// auth0 related credentials
const AUTH0_DOMAIN = 'dev-jue5bhlw.us.auth0.com';
const AUTH0_CLIENT_ID = 'izQXryBKw2WAmyuy0IyVV1znF3kez4KZ';

const AUTH0_REDIRECT_URI = 'com.auth0.botany://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     // Initialize FlutterFire:
  //     future: _initialization,
  //     builder: (context, snapshot) {
  //       // Check for errors
  //       if (snapshot.hasError) {
  //         return Center(
  //           child: Container(
  //             child: Text("Error"),
  //           ),
  //         );
  //       }

  //       // Once complete, show your application
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return StreamProvider<RegisteredUser>.value(
  //           value: AuthService().user,
  //           initialData: RegisteredUser(uid: "x", email: "x"),
  //           child: MaterialApp(
  //             home: Wrapper(),
  //           ),
  //         );
  //       }
  //       // Otherwise, show something whilst waiting for initialization to complete
  //       return Loading();
  //     },
  //   );
  // }
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = "";
  String name = "";
  String picture = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Botany',
      home: Scaffold(
        body: Container(
          child: isBusy
              ? Loading()
              : isLoggedIn
                  // ? Profile(logoutAction, name, picture)
                  ? Home(
                      name: name,
                      picture: picture,
                      logout: logoutAction,
                    )
                  : Login(loginAction, errorMessage),
        ),
      ),
    );
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access'],
          // promptValues: ['login']
        ),
      );

      final idToken = parseIdToken(result.idToken);
      final profile = await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
