import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  var charOne, charTwo;

  FirstScreen(this.charOne, this.charTwo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstScreenState(this.charOne, this.charTwo);
  }
}

class FirstScreenState extends State {
  var charOneState, charTwoState;

  FirstScreenState(this.charOneState, this.charTwoState);

  List<List> matrix;

  clearMatrix() {
    matrix = List<List>(3);
    for (var i = 0; i < matrix.length; i++) {
      matrix[i] = List(3);
      for (var j = 0; j < matrix[i].length; j++) {
        matrix[i][j] = ' ';
      }
    }
    this.turnChar = charOneState;
  }

  var turnChar = "";

  @override
  void initState() {
    this.clearMatrix();
    this.turnChar = charOneState;
  }

  String lastChar = "O";

  checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (int i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i] == player) rdiag++;

      if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
        print("$player won");
        if (player == "X") {
          alertDialog(this.charOneState);
        } else if (player == "O") {
          alertDialog(this.charTwoState);
        }
      }
    }
  }

  checkDraw() {
    var draw = true;
    matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') {
          draw = false;
        }
      });
    });
    return draw;
  }

  changeMatrixBuild(int i, int j) {
    setState(() {
      if (matrix[i][j] == ' ') {
        if (lastChar == "O") {
          matrix[i][j] = "X";
          this.turnChar = charTwoState;
        } else {
          matrix[i][j] = "O";
          this.turnChar = charOneState;
        }
        lastChar = matrix[i][j];
      }
    });
    print(this.turnChar);
  }

  loadColorBorder(int i, int j) {
    if (i == 0 && j == 0) {
      return Border(
        top: BorderSide(width: 3, color: Colors.blueAccent),
        left: BorderSide(width: 3, color: Colors.blueAccent),
      );
    } else if (i == 0 && j == 2) {
      return Border(
        top: BorderSide(width: 3, color: Colors.blueAccent),
        right: BorderSide(width: 3, color: Colors.blueAccent),
      );
    } else if (i == 2 && j == 0) {
      return Border(
        bottom: BorderSide(width: 3, color: Colors.blueAccent),
        left: BorderSide(width: 3, color: Colors.blueAccent),
      );
    } else if (i == 2 && j == 2) {
      return Border(
        right: BorderSide(width: 3, color: Colors.blueAccent),
        bottom: BorderSide(width: 3, color: Colors.blueAccent),
      );
    } else {
      return Border.all(width: 3, color: Colors.blueAccent);
    }
  }

  buildElementContainer(int i, int j) {
    return GestureDetector(
      onTap: () {
        changeMatrixBuild(i, j);
        if (checkDraw()) {
//          lastChar = "O";
          alertDialog(null);
        } else {
          checkWinner(i, j);
        }
        for (var k = 0; k < matrix.length; k++) {
          var str = '';
          for (var m = 0; m < matrix[k].length; m++) {
            str += matrix[k][m];
          }
          print(str);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: loadColorBorder(i, j),
        ),
        height: 55,
        width: 55,
        margin: EdgeInsets.all(5.0),
        child: Center(
            child: Text(
          matrix[i][j],
          style: TextStyle(fontSize: 25, color: Colors.blueAccent),
        )),
      ),
    );
  }

  alertDialog(String winner) {
    String dialogText;
    if (winner == null) {
      dialogText = "Draw";
    } else {
      dialogText = "Player $winner Won";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text('Reset Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    clearMatrix();
                  });
                },
              )
            ],
          );
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
              margin: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        this.charOneState,
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    child: Tab(
                      icon: Image.asset('images/vs.png'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        this.charTwoState,
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildElementContainer(0, 0),
                    buildElementContainer(0, 1),
                    buildElementContainer(0, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildElementContainer(1, 0),
                    buildElementContainer(1, 1),
                    buildElementContainer(1, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildElementContainer(2, 0),
                    buildElementContainer(2, 1),
                    buildElementContainer(2, 2),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "Turn ${this.turnChar}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: Tab(
                    icon: this.turnChar==charOneState?Image.asset('images/hit_two.png'):Image.asset('images/hit_one.png'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
