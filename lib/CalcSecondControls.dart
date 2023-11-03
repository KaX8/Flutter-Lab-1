
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcSecondControls extends StatelessWidget {

  final Function(String) onButtonPressed;
  final Function() onButtonLong;

  const CalcSecondControls({
    Key? key,
    required this.onButtonPressed,
    required this.onButtonLong
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    const List<String> labels = ["Back","History"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        //color: Colors.red,
        width: width,
        height: (height / 3) / 4,
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                width: 2,
              )
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onLongPress: () {
                onButtonLong();
              },
              child: FloatingActionButton.extended(
                onPressed: () {
                  onButtonPressed(labels[0]);
                },
                foregroundColor: Colors.lightGreen.shade900.withOpacity(0.5),
                backgroundColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                elevation: 0,
                icon: const Icon(Icons.backspace_outlined),
                label: Text(labels[0]),
                

              ),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                onButtonPressed(labels[1]);
              },
              foregroundColor: Colors.lightGreen.shade900.withOpacity(0.5),
              backgroundColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              icon: const Icon(Icons.access_time_outlined),
              label: Text(labels[1]),
            ),
            
          ],
        ),
      ),
    );
  }
}

FloatingActionButton getNullFAB(){
  return const FloatingActionButton(
    onPressed: null,
    foregroundColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
