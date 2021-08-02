import 'package:bayern_manager/team_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  final nameController = TextEditingController();
  final jerseyController = TextEditingController();
  final countryController = TextEditingController();
  final positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeamProvider provider = Provider.of<TeamProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Player"),
        backgroundColor: new Color(0xFF211f1f),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: new Color(0xFF545454)
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                            child: TextField(
                              controller: nameController,
                              obscureText: false,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  fillColor: Colors.white38,
                               filled: true,
                               enabledBorder: OutlineInputBorder(
                                   borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Player Name',
                              ),
                            ),
                          ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: jerseyController,
                      obscureText: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Jersey Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: countryController,
                      obscureText: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Country',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: positionController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Position',
                      ),
                    ),
                  ),

                ],
              ),
            ),
            RaisedButton(onPressed: (){
              provider.addFirebase(nameController.text, int.parse(jerseyController.text), countryController.text, positionController.text);

              Fluttertoast.showToast(
                  msg: "Player Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.pop(context);
            },child: Text("Add this player"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),)
          ],
        ),
      ),
    );
  }
}
