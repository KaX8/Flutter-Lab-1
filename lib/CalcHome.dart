import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:test_fl_kt/CalcMainControls.dart';
import 'package:test_fl_kt/CalcSecondControls.dart';

import 'CalcView.dart';

class CalcHome extends StatefulWidget {
  const CalcHome({super.key});

  @override
  State<CalcHome> createState() => _CalcHomeState();
}

class _CalcHomeState extends State<CalcHome> {
  String input = "";
  String preResult = "";


  void handleMainControlPress(String value) {

    // Определить какой тип клавиши нажат
    // Проверить, какой последний элемент в выводе (Число, Число с минусом, Знак)
    // Решить, какое действие сделать:
    //  -Добавить этот "знак" в вывод
    //  -Заменить последний элемент в выводе
    //  -Удалить вывод и preResult ( С )
    //  -Вставить в вывод preResult ( = )
    //  -Ничего
    // Обновить вывод и preResult при надобности


    // Всего 10 знаков
    // Основные: + - × ÷
    //    - Заменяются при наложении друг на друга

    // Дополнительные: ± , () %
    //    "±"
    //    - меняет знак, toggle

    //    ","
    //    - Если ставится после знака, то перед ним появляется 0:  "0,"
    //    - Иначе ставим после числа;

    //    "( )"
    //    - пиздец

    //    "%"
    //    - Нельзя установить в пустое поле
    //    - Заменяется при установке на самого себя
    //    - Если после него ставится число, то добавляется умножение: "%*7"


    // Результативные: C =
    //    "="
    //    - preResult становится на место input
    //    - preResult становится пустым
    //
    //    "C"
    //    -Очистка preResult и input
    //
    //


    setState(() {
      input = input == "0" ? value : input + value;
    });

    refreshPreResult();
  }

  void handleSecondControlPress(String value) {

    setState(() {
      switch (value){
        case "Back":
          input = input == "" ? input : input.replaceRange(input.length-1, null, "");
          refreshPreResult();
          break;
        case "History":
          // История которую я не напишу наверное...
          break;
      }
    });

  }

  void handleSecondControlLongPress() {

    setState(() {
          input = "";

    });
    refreshPreResult();
  }

  void refreshPreResult(){
    setState(() {
      try{
        Parser p = Parser();
        Expression exp = p.parse(input);

        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);

        preResult = eval.toString();
      }
      catch(e){
        preResult = "";


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    print(input);

    return Scaffold(
      body: SafeArea(
          child: Row(
            children: [
              Column(
                children: [
                  // КОНТЕЙНЕР ВЫВОДА ИНФОРМАЦИИ И ДОПОЛНИТЕЛЬНЫХ КНОПОК. ЗРЯ.
                  Container(
                    width: width,
                    height: height / 3,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CalcView(input: input, preResult: preResult),
                        CalcSecondControls(
                            onButtonPressed : handleSecondControlPress,
                            onButtonLong : handleSecondControlLongPress,
                        ),
                      ],
                    ),
                  ),
                  // КОНТЕЙНЕР КНОПОК КАЛЬКУЛЯТОРА
                  Container(
                    width: width,
                    height: height - (height / 3) - 24,
                    color: Colors.white,
                    child: CalcMainControls(onButtonPressed: handleMainControlPress),
                  ),
                ]
              )
            ],
          ),
      ),
    );
  }
}

int defineInputType(text){
  // 0 - число;
  // 1 - знак;
  //
  //
  //

  return 1;
}

