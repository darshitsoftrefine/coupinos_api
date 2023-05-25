import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'coupinos_model.dart';
class PostApiScreen extends StatefulWidget {
  const PostApiScreen({Key? key}) : super(key: key);

  @override
  State<PostApiScreen> createState() => _PostApiScreenState();
}

class _PostApiScreenState extends State<PostApiScreen> {

  ContactPerson? contDetails ;
  Address? addrDetails;
  TariffDetails? tarDetails ;
  Coupinos_Model? basicInfo;
  String baseUrl = 'https://coupinos-app.azurewebsites.net';

  @override
  void initState() {
    super.initState();
    postContactDetails();
    postAdrDetails();
    postTarDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 35,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu-JxuDBGV26p7Q2Tq-3L9By2CGBrixYvtKg&usqp=CAU'),
        ),
        title: const Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 30),),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 30, color: Colors.black,)),
          const SizedBox(width: 8,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, size: 30, color: Colors.black,)),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: postContactDetails(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                      radius: 130,
                                      child: CircleAvatar(
                                        radius: 115,
                                        backgroundImage: NetworkImage(baseUrl+'${contDetails!.profilePic}'),
                                      ),
                              ),
                                    // Image.network(baseUrl+'${contDetails!.profilePic}'),
                                        width: 100,
                                        height: 100,
                                  ),
                                  SizedBox(height: 10,),
                                  Text('Name: '+'${contDetails!.firstName}' + " " +'${contDetails!.lastName}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text("Email-Id: "+'${contDetails!.email}',style: TextStyle(fontSize: 20, color: Colors.blue)),
                                  SizedBox(height: 10,),
                                  Text("DOB: "+'${contDetails!.dob!.day}'+'/'+'${contDetails!.dob!.month}'+'/'+'${contDetails!.dob!.year}', style: TextStyle(fontSize: 20,)),
                                  SizedBox(height: 10,),
                                  Text("Gender: "+'${contDetails!.gender}', style: TextStyle(fontSize: 20)),
SizedBox(height: 40,),
                                ],
                              );
                            }

                        ),
                      ),
                    );
                  } else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ),
          FutureBuilder(
              future: postAdrDetails(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                Text("Residential Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                                SizedBox(height: 10,),
                                Text('Street: '+'${addrDetails!.street}' ,style: TextStyle(fontSize: 20),),
                                SizedBox(height: 10,),
                                Text("City: "+'${addrDetails!.city}', style: TextStyle(fontSize: 20),),
                                SizedBox(height: 10,),
                                Text("Country: "+'${addrDetails!.country}' , style: TextStyle(fontSize: 20),),
                                SizedBox(height: 10,),
                                Text("Postal code: "+'${addrDetails!.postalCode}', style: TextStyle(fontSize: 20),)
                              ],
                            );
                          }

                      ),
                    ),
                  );
                } else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
          FutureBuilder(
              future: postbasicInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                SizedBox(height: 10,),
                                Text("Id: "+'${basicInfo!.id}', style: TextStyle(fontSize: 20),)
                              ],
                            );
                          }

                      ),
                    ),
                  );
                } else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
          ),
        ],
      ),
    );
  }


  Future<ContactPerson?> postContactDetails() async {
    final response1 = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'learntest43+1@gmail.com',
        'password': 'Test@123',
      }),
    );
    var data1 = jsonDecode(response1.body) as Map<String,dynamic>;

    if (response1.statusCode == 200) {
      // for (Map<String, dynamic> index in data1) {
        contDetails = ContactPerson.fromJson(data1["contactPerson"]);
      // }
      // print(contDetails.values);
      return contDetails;
    } else {
      return contDetails;
    }
  }
  Future<Address?> postAdrDetails() async {
    final response2 = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'learntest43+1@gmail.com',
        'password': 'Test@123',
      }),
    );
    var data2 = jsonDecode(response2.body) as Map<String,dynamic>;

    if (response2.statusCode == 200) {
      // for (Map<String, dynamic> index in data1) {
      addrDetails = Address.fromJson(data2["address"]);
      // }
      // print(contDetails.values);
      return addrDetails;
    } else {
      return addrDetails;
    }
  }
  Future<TariffDetails?> postTarDetails() async {
    final response3 = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'learntest43+1@gmail.com',
        'password': 'Test@123',
      }),
    );
    var data3 = jsonDecode(response3.body) as Map<String,dynamic>;

    if (response3.statusCode == 200) {
      // for (Map<String, dynamic> index in data1) {
      tarDetails = TariffDetails.fromJson(data3["tariffDetails"]);
      // }
      // print(contDetails.values);
      return tarDetails;
    } else {
      return tarDetails;
    }
  }
  Future<Coupinos_Model?> postbasicInfo() async {
    final response4 = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'learntest43+1@gmail.com',
        'password': 'Test@123',
      }),
    );
    var data4 = jsonDecode(response4.body) as Map<String,dynamic>;

    if (response4.statusCode == 200) {
      // for (Map<String, dynamic> index in data1) {
      basicInfo = Coupinos_Model.fromJson(data4["_id"]);
      // }
      // print(contDetails.values);
      return basicInfo;
    } else {
      return basicInfo;
    }
  }
}
