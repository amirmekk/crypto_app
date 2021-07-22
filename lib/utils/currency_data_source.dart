import 'package:crypto_app/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CurrencyColumn { id, rank, name, price, oneHChange, oneDChange, marketCap }

class CurrencyDataSource extends DataGridSource {
  late Iterable<DataGridRow> _currencies;
  @override
  List<DataGridRow> get rows => _currencies.toList();

  CurrencyDataSource({required List<Currency> currencies}) {
    buildDataGrid(currencies);
  }
  void buildDataGrid(List<Currency> currencies) =>
      _currencies = currencies.map<DataGridRow>(
        (currency) => DataGridRow(
          cells: CurrencyColumn.values
              .map(
                (column) => DataGridCell<Currency>(
                  columnName: column.toString(),
                  value: currency,
                ),
              )
              .toList(),
        ),
      );

  Widget buildIdRow(Currency currency) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Text(
        currency.id,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildLogo(Currency currency) {
    final isSvg = currency.logoUrl.endsWith('.svg');
    return CircleAvatar(
        radius: 10,
        child: isSvg
            ? SvgPicture.network(currency.logoUrl)
            : Image.network(currency.logoUrl));
  }

  Widget buildPriceWidget(double price) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        '\$$price',
        style: TextStyle(color: Colors.tealAccent),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final Currency currency = dataGridCell.value;
      final column = CurrencyColumn.values
          .firstWhere((value) => value.toString() == dataGridCell.columnName);
      switch (column) {
        case CurrencyColumn.id:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(currency),
              SizedBox(
                width: 4,
              ),
              buildIdRow(currency),
            ],
          );
        case CurrencyColumn.price:
          return buildPriceWidget(currency.price);
        default:
          return Text('hello');
      }
    }).toList());
  }
}
