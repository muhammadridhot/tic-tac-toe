import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/screen/FirstScreen.dart';

class ScreenCharacter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenCharacterState();
  }
}

class ScreenCharacterState extends State {

  var charOneTextEditingCtrl = TextEditingController();
  var charTwoTextEditingCtrl = TextEditingController();

  var charOne="";
  var charTwo="";


  @override
  void initState() {
    charOneTextEditingCtrl.addListener((){
      charOne = charOneTextEditingCtrl.text;
    });
    charTwoTextEditingCtrl.addListener((){
      charTwo = charTwoTextEditingCtrl.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 2,
                  color: Colors.lightBlue,
                ),
              ),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("Input Your Character"),
                  ),
                  Container(
                    child: TextFormField(
                      controller: charOneTextEditingCtrl,
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: charTwoTextEditingCtrl,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.lightBlue,
                    child: Text("Fight",style: TextStyle(
                        color: Colors.white
                    ),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen(charOne,charTwo)));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
