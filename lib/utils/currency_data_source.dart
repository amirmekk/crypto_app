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
                (column) => DataGridCell<CurrencyComparable>(
                  columnName: column.toString(),
                  value: CurrencyComparable(column, currency),
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

  Widget buildMarketCapWidget(double marketCap) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        '\$$marketCap',
        style: TextStyle(color: Colors.tealAccent),
      ),
    );
  }

  Widget buildNameWidget(String name) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        '$name',
      ),
    );
  }

  Widget buildOneDChangeWidget(double oneDayChange) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        oneDayChange > 0 ? '$oneDayChange% ↑' : '$oneDayChange% ↓',
        style: TextStyle(color: oneDayChange > 0 ? Colors.green : Colors.red),
      ),
    );
  }

  Widget buildOneHChangeWidget(double oneHourChange) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        oneHourChange > 0 ? '$oneHourChange% ↑' : '$oneHourChange% ↓',
        style: TextStyle(color: oneHourChange > 0 ? Colors.green : Colors.red),
      ),
    );
  }

  Widget buildRankWidget(int rank) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        '$rank',
        //style: TextStyle(color: Colors.),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final CurrencyComparable currencyWrapper = dataGridCell.value;
      final currency = currencyWrapper.currency;
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

        case CurrencyColumn.marketCap:
          return buildMarketCapWidget(currency.marketCap);

        case CurrencyColumn.oneDChange:
          return buildOneDChangeWidget(currency.oneDayChange);
        case CurrencyColumn.name:
          return buildNameWidget(currency.name);
        case CurrencyColumn.oneHChange:
          return buildOneHChangeWidget(currency.oneHourChange);
        case CurrencyColumn.rank:
          return buildRankWidget(currency.rank);
        default:
          return Text('hello');
      }
    }).toList());
  }
}
