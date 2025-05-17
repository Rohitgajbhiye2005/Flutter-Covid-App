import 'dart:convert';

import 'package:covid_app/model/worldstate.dart';
import 'package:covid_app/services/utilites/app_url.dart';
import 'package:http/http.dart' as http;

class Statesservices {

  Future<worldstates>fetchworldstates()async{
    final response=await http.get(Uri.parse(AppUrl.worldstatStateApi));
    

    if(response.statusCode == 200){
      var data=jsonDecode(response.body.toString());
      return worldstates.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }


  Future<List<dynamic>> fetchcountrylist() async {
  final response = await http.get(Uri.parse(AppUrl.countrieslist));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load countries');
  }
}



}