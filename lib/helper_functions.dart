import 'package:http/http.dart' as http;

import 'dart:convert';


Future getFutureData() async {
  final response = await http.get("https://api.covid19india.org/data.json");

  if(response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Unable to fetch json data");
    return null;
  }
}