import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'dart:convert' as convert;

class UserScreen extends StatefulWidget {
  final String search;
  const UserScreen({Key? key, required this.search}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    String search = widget.search;
    getUserData(search);
    return Text("User Screen",
        style: Theme.of(context).textTheme.headlineMedium);
  }
}

void getUserData(String search) async {
  var url = Uri.https('api.github.com', '/search/users', {'q': search});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['total_count'];
    // https://github.com/kvnwj/pensil/blob/master/lib/services/m_coin_services.dart
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
