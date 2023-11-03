import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_fl_kt/CalcView.dart';

class CalcMainControls extends StatelessWidget {

  final Function(String) onButtonPressed;

  const CalcMainControls({Key? key, required this.onButtonPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double height1 = height - height / 3;
    double width = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getRowControls(["C","( )","%","/"]),
            getRowControls(["7","8","9","*"]),
            getRowControls(["4","5","6","-"]),
            getRowControls(["1","2","3","+"]),
            getRowControls(["±","0",".","="]),

          ],
        ),

      ),
    );
  }

  Row getRowControls(List<String> s){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getControl(s[0]),
        getControl(s[1]),
        getControl(s[2]),
        getControl(s[3]),
      ],
    );
  }

  Padding getControl(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          child: Text(
            s,
            style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 80),
                fontSize: 20
            ),
          ),
        onPressed: () {
          onButtonPressed(s);  // Здесь вызывается callback-функция
        },
      ),
    );
  }

}


