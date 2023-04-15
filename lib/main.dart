// ignore_for_file: prefer_const_constructors

import 'package:calculator/controller/calculator_provider.dart';
import 'package:calculator/views/calculator.dart';
import 'package:calculator/views/history.dart';
import 'package:calculator/model/historyitem.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

const buttonsBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const backgroundColor = Color.fromARGB(255, 31, 9, 49);
const yellowColor = Color.fromARGB(255, 230, 166, 39);
const whiteColor = Color.fromARGB(255, 33, 4, 42);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            color: backgroundColor,
            elevation: 0.0,
          ),
          textTheme: TextTheme(
            headline3: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            caption: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 18.0,
            ),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: yellowColor),
        ),
        routes: {
          '/': (context) => Calculator(),
          '/history': (context) => History(),
        },
      ),
    );
  }
}

AppBar appbar(
  BuildContext context,
  String title,
  IconData icon,
  Function() tap,
) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: tap,
        icon: Icon(icon),
      ),
    ],
  );
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isColored, isEqualSign, canBeFirst;
  const CalculatorButton(
    this.label, {
    this.isColored = false,
    this.isEqualSign = false,
    this.canBeFirst = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider =
        Provider.of<CalculatorProvider>(context, listen: false);
    final TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      color: buttonsBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          calculatorProvider.addToEquation(
            label,
            canBeFirst,
            context,
          );
        },
        child: Center(
          child: isEqualSign
              ? Container(
                  height: mediaQuery.width * 0.11,
                  width: mediaQuery.width * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: yellowColor,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: textStyle?.copyWith(color: backgroundColor),
                    ),
                  ),
                )
              : Text(
                  label,
                  style: textStyle?.copyWith(
                      color: isColored ? yellowColor : whiteColor),
                ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 400),
    ),
  );
}

List<CalculatorButton> buttons = <CalculatorButton>[
  CalculatorButton('AC', canBeFirst: false),
  CalculatorButton('⌫', canBeFirst: false),
  CalculatorButton('.', canBeFirst: false),
  CalculatorButton(' ÷ ', isColored: true, canBeFirst: false),
  CalculatorButton('7'),
  CalculatorButton('8'),
  CalculatorButton('9'),
  CalculatorButton(' × ', isColored: true, canBeFirst: false),
  CalculatorButton('4'),
  CalculatorButton('5'),
  CalculatorButton('6'),
  CalculatorButton(' - ', isColored: true, canBeFirst: false),
  CalculatorButton('1'),
  CalculatorButton('2'),
  CalculatorButton('3'),
  CalculatorButton(' + ', isColored: true, canBeFirst: false),
  CalculatorButton('00'),
  CalculatorButton('0'),
  CalculatorButton('000'),
  CalculatorButton('=', isEqualSign: true, canBeFirst: false),
];
