import 'package:bayern_manager/team_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditData extends StatefulWidget {

  String player_Name;
  EditData(this.player_Name);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  final nameController = TextEditingController();
  final nationalityController = TextEditingController();
  final jerseyController = TextEditingController();
  final countryController = TextEditingController();
  final ageController = TextEditingController();
  final positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeamProvider provider = Provider.of<TeamProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Player Data"),
        backgroundColor: new Color(0xFF211f1f),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${widget.player_Name}",style: TextStyle(fontSize: 20,color: Colors.white),),
          ),),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: jerseyController,
                      obscureText: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Edit Jersey Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: countryController,
                      obscureText: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Edit Country',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: positionController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Edit Position',
                      ),
                    ),
                  ),
                  RaisedButton(onPressed: (){
                    provider.updateFirebase(widget.player_Name,int.parse(jerseyController.text),countryController.text, positionController.text);
                    Fluttertoast.showToast(
                        msg: "Player Edited",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    Navigator.pop(context);
                  },child: Text("Edit player"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
