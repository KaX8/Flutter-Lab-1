import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  // Прозошло нажатие одной из основной клавиш управления
  void handleMainControlPress(String newSymbol) {

    String currentInput = input;

    // Проверяем, является ли новый символ цифрой
    if (RegExp(r'[0-9]').hasMatch(newSymbol)) {
      // Если новый символ - ноль, проверяем условия для его добавления
      if (newSymbol == '0') {
        if (currentInput.isNotEmpty) {
          currentInput += newSymbol;
        } else {
          // Добавляем ноль только если он первый символ
          currentInput = '0';
        }
      } else {
        // Для других цифр просто добавляем символ
        currentInput += newSymbol;
      }
    } else if (newSymbol == '.' || RegExp(r'[\^\+\*/]').hasMatch(newSymbol)) {
      // Для точки и арифметических операторов проверяем, что последний символ - цифра
      if (currentInput.isNotEmpty && RegExp(r'[0-9]').hasMatch(currentInput[currentInput.length - 1])) {
        currentInput += newSymbol;
      }
    } else if (newSymbol == '-' || RegExp(r'[\^\+\-\*/]').hasMatch(newSymbol)) {
      // Разрешаем минус, если currentInput пустой
      if (currentInput.isEmpty && newSymbol == '-') {
        currentInput += newSymbol;
      }
      // Разрешаем минус после числа или оператора, если последний символ не минус
      else if (currentInput.isNotEmpty && !currentInput.endsWith('-') && (RegExp(r'[0-9]').hasMatch(currentInput[currentInput.length - 1]) || RegExp(r'[\^\+\-\*/]').hasMatch(currentInput[currentInput.length - 1]))) {
        currentInput += newSymbol;
      }
    }else if (newSymbol == 'C') {
      currentInput = '';
    }else if (newSymbol == '=') {
      if (preResult.isNotEmpty) {
        currentInput = preResult;
        preResult = "";
      }else {
        print("Нельзя! Допишите выражение");
      }
    }

    // Обновляем состояние ввода
    setState(() {
      input = currentInput;
      preResult = refreshPreResult();
    });

  }

  // Прозошло нажатие одной из дополнительных клавиш управления
  void handleSecondControlPress(String value) {

    setState(() {
      switch (value){
        case "Back":
          input = input == "" ? input : input.replaceRange(input.length-1, null, "");
          preResult = refreshPreResult();
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
          preResult = "";
    });
  }

  String refreshPreResult() {

    if (input.isEmpty || !RegExp(r'[0-9]').hasMatch(input)) return "";



    RegExp numRegExp = RegExp(r'-?\d+\.?\d*'); // Ищем чиселки, возможно с минусом
    RegExp opRegExp = RegExp(r'[\^\+\-\*/]');  // Ищем операторы


    List<double> numbers = [];
    List<String> operators = [];

    int index = 0;
    bool expectOperator = false; // Флаг, ожидаем ли мы оператор

    // госпади е
    while (index < input.length) {
      if (!expectOperator) {
        var numMatch = numRegExp.firstMatch(input.substring(index));
        if (numMatch != null) {
          numbers.add(double.parse(numMatch.group(0)!));
          index += numMatch.end;
          expectOperator = true; // После числа ожидаем оператор
        } else {
          index++;
        }
      } else {
        var opMatch = opRegExp.firstMatch(input.substring(index));
        if (opMatch != null) {
          operators.add(opMatch.group(0)!);
          index += opMatch.end;
          expectOperator = false; // После оператора ожидаем число
        } else {
          index++;
        }
      }
    }

    try{

      print("Считаем!");
      // Функция для выполнения операции
      double performOperation(double a, double b, String op) {
        switch (op) {
          case '^':
            return pow(a,b);
          case '*':
            return a * b;
          case '/':
            return a / b;
          case '+':
            return a + b;
          case '-':
            return a - b;
          default:
            throw Exception('О господи что случилось опять все сломалось');
        }
      }

      // Вычисление приоритетных операций (* и /)
      for (int i = 0; i < operators.length; i++) {
        if (operators[i] == '*' || operators[i] == '/' || operators[i] == '^') {
          numbers[i] = performOperation(numbers[i], numbers[i + 1], operators[i]);
          numbers.removeAt(i + 1);
          operators.removeAt(i);
          i--;
        }
      }

      // Вычисление оставшихся операций (+ и -)
      while (operators.isNotEmpty) {
        numbers[0] = performOperation(numbers[0], numbers[1], operators[0]);
        numbers.removeAt(1);
        operators.removeAt(0);
      }
    }
    catch (Exception){
      print(Exception);
      return "";
    }


    String result = (numbers[0] % 1 == 0)
        ? numbers[0].toInt().toString()
        : numbers[0].toString();

    return result;
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
                    height: height - (height / 3) - 27,
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

double pow(double a, double b) {
  if (b == 0) {
    return 1;
  }

  double result = 1;
  bool isNegative = b < 0;

  if (isNegative) {
    a = 1 / a;
    b = -b;
  }

  for (int i = 0; i < b; i++) {
    result *= a;
  }

  return result;
}





