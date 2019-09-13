import 'package:bmi_calculator/calculate.dart';
import 'package:bmi_calculator/constant.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constant.dart';
import 'result.dart';
//0xFF1C1C32
//custom varibales declaration

enum Gender {
  male,
  female,
}
//Done
void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
        ),
      ),
      routes: {
        '/': (context) => InputPage(),
        '/result': (context) => Result(),
      },
      initialRoute: "/",
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int _val = 300;

  int _age = 21;
  int _weight = 30;
  Gender selectedgender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Customcard(
                    ontap: () {
                      setState(() {
                        selectedgender = Gender.male;
                      });
                    },
                    cardcolor: selectedgender == Gender.male
                        ? activecardcolor
                        : cardcolor,
                    content: Cardcontent(
                      icon: FontAwesomeIcons.mars,
                      text: "MALE",
                    ),
                  ),
                ),
                Expanded(
                  child: Customcard(
                    ontap: () {
                      setState(() {
                        selectedgender = Gender.female;
                      });
                    },
                    cardcolor: selectedgender == Gender.female
                        ? activecardcolor
                        : cardcolor,
                    content: Cardcontent(
                      icon: FontAwesomeIcons.venus,
                      text: "FEMALE",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Customcard(
              cardcolor: cardcolor,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Height",
                    style: kTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        "$_val",
                        style: kNumberStyle,
                      ),
                      Text(
                        "Cm",
                        style: kTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Color(0xFFEB1455),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                      overlayColor: Color(0x29EB1455),
                    ),
                    child: Slider(
                      min: 100.0,
                      max: 500.0,
                      divisions: 400,
                      onChanged: (double newValue) {
                        setState(() {
                          _val = newValue.toInt();
                        });
                      },
                      value: _val.toDouble(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Customcard(
                    cardcolor: cardcolor,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Weight", style: kTextStyle),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              "$_weight",
                              style: kNumberStyle,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Kg",
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundActionButton(
                              icon: FontAwesomeIcons.minus,
                              onpressed: () {
                                setState(() {
                                  _weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundActionButton(
                              icon: FontAwesomeIcons.plus,
                              onpressed: () {
                                setState(() {
                                  _weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Customcard(
                    cardcolor: cardcolor,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Age", style: kTextStyle),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              "$_age",
                              style: kNumberStyle,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "yrs",
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundActionButton(
                              icon: FontAwesomeIcons.minus,
                              onpressed: () {
                                setState(() {
                                  _age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundActionButton(
                              icon: FontAwesomeIcons.plus,
                              onpressed: () {
                                setState(() {
                                  _age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Bottomnavbar(
            content: Text(
              "Calculate",
              textAlign: TextAlign.center,
              style: kTextStyle,
            ),
            ontap: () {
              calculate calc =
                  new calculate(height: _val, weight: _weight, age: _age);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Result(
                            bmiresult: calc.calcutateresult(),
                            bmistatus: calc.calculatestats(),
                            bmiinterp: calc.calculateinterp(),
                          )));
            },
          ),
        ],
      ),
    );
  }
}

class Bottomnavbar extends StatelessWidget {
  final Function ontap;
  final Widget content;
  Bottomnavbar({this.content, this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(top: 10),
        height: 50,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(color: kBottomNavBarColor),
        child: content,
      ),
    );
  }
}

// custom card class
class Customcard extends StatelessWidget {
  final Color cardcolor;
  final Widget content;
  final Function ontap;
  Customcard({@required this.cardcolor, this.content, this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cardcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: content,
      ),
    );
  }
}

//Icon content class

class Cardcontent extends StatelessWidget {
  Cardcontent({this.icon, this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: (constraints.maxHeight + constraints.maxWidth) / 4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  text,
                  style: kTextStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

//RoundActionButon
class RoundActionButton extends StatelessWidget {
  final Function onpressed;
  final IconData icon;

  RoundActionButton({
    this.onpressed,
    this.icon,
  });
  final int kSize = 56;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: Color(0xFF4c4f5e),
      onPressed: onpressed,
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(
        height: kSize.toDouble(),
        width: kSize.toDouble(),
      ),
    );
  }
}
