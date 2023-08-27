import 'package:flutter_expense_tracker/bar%20graph/indiviual_bar.dart';

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData(
      {required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount,
      required this.sunAmount});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      //monday
      IndividualBar(x: 0, y: monAmount),
      //tuesday
      IndividualBar(x: 1, y: tueAmount),
      //wednesday
      IndividualBar(x: 2, y: wedAmount),
      //thursday
      IndividualBar(x: 3, y: thuAmount),
      //friday
      IndividualBar(x: 4, y: friAmount),
      //saturday
      IndividualBar(x: 5, y: satAmount),
      //sunday
      IndividualBar(x: 6, y: sunAmount)
    ];
  }
}
