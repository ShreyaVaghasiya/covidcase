import 'dart:convert';
import 'dart:developer';
import 'package:covidcase/HttpService.dart';
import 'package:covidcase/Responses/statewiseresponse.dart';
import 'package:covidcase/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Responses/countrywiseresponse.dart';

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
  List<UserResponse> dataList = [];
  List<dynamic> finalList = [];
  dynamic mycolor1 = CupertinoColors.black;
  dynamic mycolor2 = CupertinoColors.black;
  dynamic mycolor3 = CupertinoColors.black;
 HttpService httpService = HttpService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: h / 3,
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
                  top: h / 6,
                  right: w / 50,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: h / 14,
                    width: w / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CupertinoColors.white,
                        border: Border.all(
                            color: Colors.orange.shade900, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Util.tabIndex = 0;
                              mycolor1 = Colors.orange;
                              mycolor2 = CupertinoColors.black;
                              mycolor3 = CupertinoColors.black;
                            });
                          },
                          child: Text(
                            "Country Wise",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              color: mycolor1,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 25),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Util.tabIndex = 1;
                              mycolor2 = Colors.orange;
                              mycolor1 = CupertinoColors.black;
                              mycolor3 = CupertinoColors.black;
                            });
                          },
                          child: Text(
                            "State Wise",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: mycolor2,
                            ),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 25),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Util.tabIndex = 2;

                              mycolor3 = Colors.orange;
                              mycolor1 = CupertinoColors.black;
                              mycolor2 = CupertinoColors.black;
                            });
                          },
                          child: Text(
                            "City Wise",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w600,
                              color: mycolor3,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (Util.tabIndex == 1)
              ? Expanded(
                  child:  FutureBuilder(
                      future: httpService.getStateUiResponse(),
                      builder:(context,snapshot) {
                        if (snapshot.hasData) {
                         List<UserResponse> state = snapshot.data;
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  height: h / 6,
                                  width: w,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.secondaryLabel,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${state[index].province}".substring(9),style: GoogleFonts.lato(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 1
                                        ),),
                                        Text("Active Case : ${state[index].active}",style: GoogleFonts.lato(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 1
                                        ),),
                                        Text("Confirm Case : ${state[index].confirmed}",style: GoogleFonts.lato(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 1
                                        ),),
                                        Text("Death : ${state[index].confirmed}",style: GoogleFonts.lato(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 1
                                        ),),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }

                  ),

          ):(Util.tabIndex == 2)?Column()
              : Expanded(child: FutureBuilder(
            future: httpService.getCountryUiResponse(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                List<stateResponse> country = snapshot.data!;
                return ListView.builder(
                    itemCount: country.length,
                    itemBuilder: (context, index) =>
                        Container(
                            margin: EdgeInsets.all(15),
                            height: h / 6,
                            width: w,
                            decoration: BoxDecoration(
                              color: CupertinoColors.secondaryLabel,
                              border: Border.all(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:h/14,
                                  width: w/3.2,
                                  child: Image.network('${country[index].countryInfo!.flag}'),),

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${country[index].country}",style: GoogleFonts.lato(
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1
                                    ),),
                                    Text("Active Case : ${country[index].active}",style: GoogleFonts.lato(
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1
                                    ),),
                                    Text("Critical Case : ${country[index].active}",style: GoogleFonts.lato(
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1
                                    ),),
                                    Text("Death : ${country[index].deaths}",style: GoogleFonts.lato(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          )
                        ));
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          )),
        ],
      ),
      backgroundColor: Colors.black,
    );

  }

}
