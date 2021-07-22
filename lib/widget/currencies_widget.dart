import 'package:crypto_app/provider/currency_provider.dart';
import 'package:crypto_app/utils/currency_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CurrenciesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrencyProvider>(context);
    final currencyDataSource = provider.currencyDataSource;
    if (currencyDataSource == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SfDataGrid(
        source: currencyDataSource,
        columns: buildGridColumns(),
      );
    }
  }

  List<GridColumn> buildGridColumns() {
    return <GridColumn>[
      GridTextColumn(
        columnName: CurrencyColumn.id.toString(),
        label: buildLabel('ID'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.rank.toString(),
        label: buildLabel('Rank'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.name.toString(),
        label: buildLabel('Name'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.price.toString(),
        label: buildLabel('Price'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.oneHChange.toString(),
        label: buildLabel('last 1H'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.oneDChange.toString(),
        label: buildLabel('last 1D'),
      ),
      GridTextColumn(
        columnName: CurrencyColumn.marketCap.toString(),
        label: buildLabel('market cap'),
      ),
    ];
  }

  Widget buildLabel(String text) {
    return Text(text);
  }
}
