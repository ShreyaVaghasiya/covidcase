import 'dart:convert';

import 'dart:developer';
import 'package:covidcase/Responses/contrywiseresponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserResponse userResponse = UserResponse();
  List<Map<String,dynamic>> dataList = [];
  var data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryUiResponse();
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: h/3,
            width: w,
            child: Stack(
              children: [
                Positioned(
                  top: h / 22,
                  child: Container(
                    width: w,
                    child: Image(
                      image: AssetImage('assets/myimages/covid-header-2.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Positioned(
              top: h/6,
                right: w/50,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: h/14,
                  width: w/1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.white,
                    border:Border.all(color: Colors.orange.shade900,width: 2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Country Wise",style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),
                     Text("|",style: TextStyle(fontSize: 25),),
                      Text("State Wise",style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),   Text("|",style: TextStyle(fontSize: 25),),
                      Text("City Wise",style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),)
                    ],
                  ),
                ),
              ),

              ],
            ),
          ),

        ],
      ),
      backgroundColor: Colors.black,
    );
  }
  getCountryUiResponse()async{
    var url = Uri.parse('https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true');
    var response = await http.get(url);
     try{
       setState(() {

       });
       if(response.statusCode == 200){
         userResponse = UserResponse.fromJson(json.decode(response.body));

       }
       else{
         print("No Data Found !");
       }
       return userResponse;
     }
     catch(e){
       log(e.toString());
     }
  }
}
