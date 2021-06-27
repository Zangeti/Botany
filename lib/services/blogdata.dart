// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class BlogData {
  Future<http.Response> fetchencyclypedia() async{
    return await http
        .get(Uri.parse('https://botanyapi.herokuapp.com/botany/encyclopedia'));
  }
}
