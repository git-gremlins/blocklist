import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: GridRow(
                columns: 2,
              ),
            ),
            Expanded(
              child: GridRow(
                columns: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridMain extends StatelessWidget {
    @override
      Widget build(BuildContext context) {
        return Column(children: List.filled(GridRow(columns: ,), rows),)
      }
}

class GridRow extends StatelessWidget {
  int columns;
  GridRow({required this.columns});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.filled(
        columns,
        Expanded(
          child: GridContainer(),
        ),
      ),
    );
  }
}

class GridContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[200],
        border: Border.all(color: Colors.red),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
