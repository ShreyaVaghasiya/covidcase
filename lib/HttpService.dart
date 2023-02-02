import 'dart:convert';
import 'dart:developer';

import 'package:covidcase/Responses/statewiseresponse.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Responses/countrywiseresponse.dart';

class HttpService {

  Future getStateUiResponse() async {
    log("getStateUiResponse | started");
    var url = Uri.parse(
        'https://api.covid19api.com/live/country/India/status/status');
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List state = data.map((e) => UserResponse.fromJson(e)).toList();
      return state;
    } else {
      print("No Data Found !");
    }
  }
   
  Future getCountryUiResponse()async{
    
    var url = Uri.parse('https://disease.sh/v3/covid-19/countries');
    Response response = await http.get(url);
    if(response.statusCode == 200){
      List<dynamic> data1 = jsonDecode(response.body);
      List country = data1.map((e) => stateResponse.fromJson(e)).toList();
      return country;
    }
    else{
      print("Data Not Found!");
    }
  }
  
}
