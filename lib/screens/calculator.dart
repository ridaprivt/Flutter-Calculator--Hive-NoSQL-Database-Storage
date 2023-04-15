// ignore_for_file: prefer_const_constructors

import 'package:calculator/provider/calculator_provider.dart';
import 'package:calculator/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbar(
        context,
        'Calculator',
        Icons.history,
        () {
          Navigator.pushNamed(context, '/history');
        },
      ),
      body: Column(
        children: [
          Container(
            width: mediaQuery.width,
            height: mediaQuery.height * .35,
            padding: EdgeInsets.symmetric(
              vertical: mediaQuery.width * 0.08,
              horizontal: mediaQuery.width * 0.06,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 20.0,
                  child: ListView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Consumer<CalculatorProvider>(
                        builder: (context, equation, child) => Text(
                          equation.equation,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Consumer<CalculatorProvider>(
                  builder: (context, equation, child) => Text(
                    equation.result,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(22.0)),
              child: Container(
                width: double.infinity,
                color: buttonsBackgroundColor,
                padding: EdgeInsets.only(top: 10.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(17.0),
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 5.0,
                  crossAxisCount: 4,
                  children: buttons,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
