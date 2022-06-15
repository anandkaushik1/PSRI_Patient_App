// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of a simple line chart.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: new Container(
              margin: EdgeInsets.only(top: 30),
              color: Colors.white,
              //child:new charts.LineChart(_createSampleDataLine(), animate: false) ,
            ),
          ),
          Expanded(
            flex:7,
            child: new Center(
              child: Text("data"),
            ),
          )
        ],
      ),

    );

  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createSampleDataLine() {
    final data = [
      new LinearSales("0", 5),
      new LinearSales("1", 25),
      new LinearSales("2", 100),
      new LinearSales("3", 75),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String year;
  final int sales;

  LinearSales(this.year, this.sales);
}
