import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';

import 'package:http/http.dart' as http;
import 'package:responsive_admin_dashboard/user screens/user-components/oneticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';


import 'package:flutter/cupertino.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_admin_dashboard/AllusersAdmin.dart';


class Ticket extends StatefulWidget {
  @override
  State<Ticket> createState() => _DashuserState();
}

class _DashuserState extends State<Ticket> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

var techniciens;
 var technicien;
  getTechniciens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var url = "http://localhost:3000/api/groupe/getgroupes";
    var uri = Uri.parse(url);
    // var request = http.get(uri, headers: headers);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      techniciens = jsonDecode(response.body);
    });
  }
   String selectedValue2 = '';
List<DropdownMenuItem<String>> get dropdownItems2{
  List<DropdownMenuItem<String>> menuItems2 = [
    DropdownMenuItem(child: Text(''),value:''), 
     for (technicien in techniciens)
   
    DropdownMenuItem(child: Text(technicien['specialite']),value: technicien['_id']),
   // DropdownMenuItem(child: Text("technicien"),value: "technicien"),
    
  
  ];
  return menuItems2;
}







   String selectedValue = "Urgent";
List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Urgent"),value: "Urgent"),
    DropdownMenuItem(child: Text("Moyenne"),value: "Moyenne"),
    DropdownMenuItem(child: Text("faible"),value: "Faible"),
 
  ];
  return menuItems;
}
  var users;
  
  getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String token = prefs.getString("token");
     String userId = prefs.getString("userId");
    String clubId = prefs.getString("club_id");
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
   // var url = "http://localhost:3000/api/users/tickets";
   // };http://localhost:3000/api/tickets/${id}/deleteticket
    var uri = Uri.parse("http://localhost:3000/api/tickets/" +
       userId +
        "/getUsertickets");
        //http://localhost:3000/api/tickets/${id}/getTechtickets
    //var uri = Uri.parse(url);
    // var request = http.get(uri, headers: headers);
    var request = http.get(uri, headers: headers);
    var response = await request.timeout(Duration(seconds: 10));
    setState(() {
      users = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    getTechniciens();
  }


  //XFile
 // XFile;

    XFile _file;
 

TextEditingController _descriptionController = TextEditingController();
  TextEditingController _prioriteController = TextEditingController();


  //XFile
 

  AddTicket( ) async {
 
   SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId");
     String token = prefs.getString("token");
   var body = {
      "description": _descriptionController.text,
      "specialite":selectedValue2,
     "priorite":selectedValue
    };
   var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token,
      "userId": userId,
    };
    var uri = Uri.parse("http://localhost:3000/api/tickets/" +
        userId +
        "/addticket");
        var request = http.post(uri,  body: json.encode(body), headers: headers);
   // var request = new http.MultipartRequest("POST", uri);
    
    //request.fields['description'] = description;
    ///request.fields['priorite'] = email;
 
    //var response = await request.send();
    // Fluttertoast.showToast(
    //     msg: "User Added Successfully",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    //response.stream.transform(utf8.decoder).listen((value) {});
    //return response;
      // var response = await request.send();
    // print(response.statusCode);

    // // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
  }

 
// var uri = Uri.parse("http://localhost:3000/api/users/addUser2");

//     // create multipart request
//     var request = new http.MultipartRequest("POST", uri);

//     // multipart that takes file
//     //var multipartFile = new http.MultipartFile('myFile', stream, length,
//       //  filename: basename(imageFile.path));

//     // add file to multipart
//    // request.files.add(multipartFile);

//     // send
//         request.fields['name'] = name;
//     request.fields['email'] = email;
//     request.fields['password'] = password;
//     request.fields['type'] = type;
//     var response = await request.send();
//     print(response.statusCode);

//     // listen for response
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//     });









    final ScrollController _firstController = ScrollController();
  // Discussions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tickets ',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
               FloatingActionButton.extended(
        onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>RegistrationPage() ));
          // Add your onPressed code here!
           showDialog(
         context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    
  elevation: 20,
  shape: RoundedRectangleBorder(
      side:  BorderSide(color:  HexColor('#008ea1'),width: 3),
      borderRadius: BorderRadius.all(Radius.circular(15))
  ),
  backgroundColor: HexColor('#f6f6f6'),
                    scrollable: true,
                   // title: Text('Cloturer '),
                   
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                         
                   
                
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "le problème",
                        hintStyle: TextStyle(color: CupertinoColors.activeBlue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 40,
                    ),
                            Text(
                     'priorité',
                          textAlign: TextAlign.right,
                    style: TextStyle(
                      
                      color: textColor,
                      fontWeight: FontWeight.w400
                    ),

                  ),   SizedBox(
                      height: 20,
                    ),
                DropdownButton(
      value: selectedValue,
      dropdownColor:CupertinoColors.activeBlue,
      isExpanded:true,
      onChanged: (String newValue){
        setState(() {
          selectedValue = newValue;
        });
      },
      items: dropdownItems
      ),   
   SizedBox(
                      height: 40,
                    ),
                      Text(
                     'problème de',
                          textAlign: TextAlign.right,
                    style: TextStyle(
                      
                      color: textColor,
                      fontWeight: FontWeight.w400
                    ),

                  ), 
                    SizedBox(
                      height: 10,
                    ),
            DropdownButton(
      value: selectedValue2,
      dropdownColor:CupertinoColors.activeBlue,
      isExpanded:true,
      onChanged: (String newValue){
        setState(() {
          selectedValue2 = newValue;
        });
      },
      items: dropdownItems2
      ),
         SizedBox(
                      height: 70,
                    ),
                       Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  
  children: <Widget>[
    new Container(
      width:350,
      child: FloatingActionButton.extended(
        onPressed: () {
    
AddTicket()  ;


        },
        label: const Text('ajouter'),
        // icon: const Icon(Icons.plus_one_rounded),
        backgroundColor:   HexColor('#00a5bb'),
  shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero
     ),
      ), 
    )
  ],
),
      

                    // TextField(
                    //   controller: _prioriteController,
                    //   decoration: InputDecoration(
                    //     hintText: "priorité : (faible/moyenne/urgent)",
                    //     hintStyle: TextStyle(color: CupertinoColors.activeBlue),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 70,
                    ),
                    
              
                          ],
                        ),
                      ),
                    ),
                     actions: [
    
                //         ElevatedButton(
              
                //    onPressed: () async{
                  
                //     await AddTicket(
                       
                      
                     
                //         );
                //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashuser()));
                //   },
                //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllusersAdmin()));
                //  // },
                //   child: Text('ajouter')) 
                          
                    ],
                  );
                });


          
        },
        label: const Text('Ajouter'),
        // icon: const Icon(Icons.plus_one_rounded),
        backgroundColor: Colors.blue,

      ),
              // Text(
              //   'View All',
              //   style: TextStyle(
              //     color: textColor.withOpacity(0.5),
              //     fontWeight: FontWeight.bold,
              //     fontSize: 13,
              //   ),
              // ),
      //         FloatingActionButton.extended(
      //   onPressed: () {
      //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>RegistrationPage() ));
      //     // Add your onPressed code here!
      //      showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //               scrollable: true,
      //               title: Text('User Add'),
      //               content: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Form(
      //                   child: Column(
      //                     children: <Widget>[
      //                       // TextFormField(
      //                       //   decoration: InputDecoration(
      //                       //     labelText: 'Name',
      //                       //     icon: Icon(Icons.account_box),
      //                       //   ),
      //                       // ),

      //                       // TextFormField(
      //                       //   decoration: InputDecoration(
      //                       //     labelText: 'Email',
      //                       //     icon: Icon(Icons.email),
      //                       //   ),
      //                       // ),
      //                       // TextFormField(
      //                       //   decoration: InputDecoration(
      //                       //     labelText: 'Message',
      //                       //     icon: Icon(Icons.message ),
      //                       //   ),
      //                       // ),
      //               //               Container(
      //               //   width: MediaQuery.of(context).size.width,
      //               //   child: ElevatedButton(
      //               //     child: Text('Upload Image'),
      //               //     style: ElevatedButton.styleFrom(
      //               //       primary: Colors.green[800],
      //               //     ),
      //               //     onPressed: () async {
      //               //       final pickedFile = await ImagePicker()
      //               //           .pickImage(source: ImageSource.gallery);
      //               //       setState(() {
      //               //         // _file = pickedFile;
      //               //       });
      //               //     },
      //               //   ),
      //               // ),
      //               TextField(
      //                 controller: _nameController,
      //                 decoration: InputDecoration(
      //                   hintText: "Name",
      //                   hintStyle: TextStyle(color: CupertinoColors.activeBlue),
      //                   border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               TextField(
      //                 controller: _emailController,
      //                 decoration: InputDecoration(
      //                   hintText: "Email",
      //                   hintStyle: TextStyle(color: CupertinoColors.activeBlue),
      //                   border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                 ),
      //               ),
      //                SizedBox(
      //                 height: 20,
      //               ),
      //                   TextField(
      //                 controller: _passwordController,
      //                 decoration: InputDecoration(
      //                   hintText: "Password",
      //                   hintStyle: TextStyle(color: CupertinoColors.activeBlue),
      //                   border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                 ),
      //               ),
      //                SizedBox(
      //                 height: 20,
      //               ),
      //               TextField(
      //                 controller: _typeController,
      //                 decoration: InputDecoration(
      //                   hintText: "Type : (Admin/technicien)",
      //                   hintStyle: TextStyle(color: CupertinoColors.activeBlue),
      //                   border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 child: ElevatedButton(
      //                   child: Text('Upload Image'),
      //                   style: ElevatedButton.styleFrom(
      //                     primary: Colors.green[800],
      //                   ),
      //                   onPressed: () async {
      //                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      //                     setState(() {

      //                       // _file =pickedFile;
      //                     });
      //                   },
      //                 ),
      //               ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //                actions: [
      //   //            FloatingActionButton.extended(
       
      //   // label: const Text('ajouter'),
      //   // // icon: const Icon(Icons.plus_one_rounded),
      //   // backgroundColor: Colors.yellow,
      //   //                     onPressed: () async{
      //   //             File image = File(_file.path);
      //   //             await SignUp(
      //   //                 image,
      //   //                 _nameController.text,
      //   //                 _emailController.text,
      //   //                 _passwordController.text,
      //   //                 _typeController.text,
      //   //                 context);
      //   //            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashuser()));
      //   //              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>AllusersAdmin() ));
      //   //           },
      //   //           ),
      //                   ElevatedButton(
      //             onPressed: () async{
                 
      //               //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllusersAdmin()));
      //             },
      //             child: Text('Save')) 
                          
      //               ],
      //             );
      //           });


          
      //   },
      //   label: const Text('Ajouter'),
      //   // icon: const Icon(Icons.plus_one_rounded),
      //   backgroundColor: Colors.blue,

      // ),
            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          Expanded(
            // child: ListView.builder(
            //   // physics: NeverScrollableScrollPhysics(),
            //   physics:AlwaysScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: discussionData.length,
            //   itemBuilder: (context, index) => DiscussionInfoDetail(info: discussionData[index],),
            // ),
               child: Scrollbar(
                isAlwaysShown: true,
                controller: _firstController,
                child: ListView.builder(
                    controller: _firstController,
                     itemCount: users.length, 
                    itemBuilder:(context, index) => Oneticket(info: users[index],),
                    // (BuildContext context, int index) {
                      // return Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text('Scrollable 1 : Index $index'),
                      // );
                   // }
                    ),
              )),
          
        ],
      ),
    );
  }
}
