class Currency {
  final String id;
  final String logoUrl;
  final String name;
  final double price;
  final double oneHourChange;
  final double oneDayChange;
  final double marketCap;
  final int rank;
  final int rankDelta;

  const Currency(
      {required this.id,
      required this.logoUrl,
      required this.name,
      required this.price,
      required this.oneHourChange,
      required this.oneDayChange,
      required this.marketCap,
      required this.rank,
      required this.rankDelta});

  Currency.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.marketCap = double.parse(json['market_cap']),
        this.logoUrl = json['logo_url'],
        this.rank = int.parse(json['rank']),
        this.price = double.parse(json['price']),
        this.oneHourChange = 0.2,
        this.oneDayChange = double.parse(json['1d']['price_change_pct']),
        this.rankDelta = int.parse(json['rank_delta']);
}
