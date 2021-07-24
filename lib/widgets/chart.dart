import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions; //list of recentTransactions

  Chart(this.recentTransactions); //constructor..

  List<Map<String, Object>> get groupedTransactionValues {
    //getter method which has a return type of list of maps
    return List.generate(7, (index) {
      //call back function
      final weekDay = DateTime.now().subtract(
        //this is done to create different days using datetime.now
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending { //from groupedTrans...list we are folding i.e we have sum which we r initializing with 0.0 then after traversing the list we r adding the amount to sum variable
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum = sum + item['amount']; //total seven days ka amount will be added to sum variable...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit:FlexFit.tight,
                  child: ChartBar(data['day'], data['amount'], totalSpending == 0.0 ? 0.0 :(data['amount'] as double) / totalSpending ));
              }).toList(),
            ),
          ),);
  }
}