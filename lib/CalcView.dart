import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcView extends StatelessWidget {

  final String input;
  final String preResult;
  const CalcView({Key? key, required this.input, required this.preResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.white,
        height: ((height / 3) / 4) * 2.5,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // color: Colors.cyan,
                width: width - 48,
                height: (((((height / 3) / 4) * 2.5) - 16) / 6) * 2 ,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  child: Text(input),
                ),
              ),
              Container(
                // color: Colors.red,
                width: width - 48,
                height: ((((height / 3) / 4) * 2.5) - 16) / 5,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  child: Text(preResult, style: TextStyle(color: Colors.grey),),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

}

Text getTextWdg(String s){
  return Text(
    s,
    style: TextStyle(
      color: Colors.black,
    ),
  );
}


