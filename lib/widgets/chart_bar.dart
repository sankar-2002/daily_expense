import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) { //this constraints obj give info about all the constraints tied to chartbar..this constraints obj can be used to calculate dynamic heights of the that widget
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            //fitted box is used to shrink the text if the space is not available..
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                //maincontainer
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(
                      220, 220, 220, 1), //creating a light grey colour
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ) //overlaying on mainContainer
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text(label))),
      ],
    );
    });
  }
}
