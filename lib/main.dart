import 'package:bayern_manager/add_data.dart';
import 'package:bayern_manager/team_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';

import 'edit_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamProvider>(
      create: (context) => TeamProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFF)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Stream<QuerySnapshot> _teamStream =
  FirebaseFirestore.instance.collection('Team').snapshots();

  @override
  Widget build(BuildContext context) {
    TeamProvider provider = Provider.of<TeamProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xFF211f1f),
        title: Text("Bayern Manager"),
      ),
      body: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text("Squad",style: TextStyle(color: Colors.white,fontSize: 20),),
          ),),
          Container(
            margin: EdgeInsets.all(16),
            height: 500,
            width: 400,
            decoration: BoxDecoration(
              color: new Color(0xFF545454),
              borderRadius: BorderRadius.circular(10)
            ),

            child: StreamBuilder<QuerySnapshot>(
                stream: _teamStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return new ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      return FocusedMenuHolder(
                        onPressed: (){},
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(title: Text("Edit/Update Player"), onPressed:(){Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return EditData(data['name']);
                              }));}),
                          FocusedMenuItem(title: Text("Delete Player",style: TextStyle(color: Colors.red),), onPressed:(){
                            provider.deleteData(data['name']);
                            Fluttertoast.showToast(
                                msg: "Player Deleted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }),
                        ],
                        child: Card(
                          child: new ListTile(

                            tileColor: new Color(0xFF211f1f),
                            onTap: (){},
                            leading: new Text("${data['jersey_number']}",style: TextStyle(color: Colors.white),),
                            title: new Text(data['name'],style: TextStyle(color: Colors.white),),
                            subtitle: new Text("${data['country']}",style: TextStyle(color: Colors.white)),
                            trailing: Text(data['position'],style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
          RaisedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return AddData();
                }));
            
          },color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Add a Player"),)
        ],
      ),
    );
  }
}
