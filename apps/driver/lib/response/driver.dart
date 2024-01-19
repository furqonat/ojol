class Driver {
  final String? id;
  final DriverDetail? details;
  final DriverWallet? wallet;
  final DriverSetting? setting;

  Driver({this.id, this.details, this.wallet, this.setting});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      details: json['driver_details'] == null
          ? null
          : DriverDetail.fromJson(
              json['driver_details'],
            ),
      wallet: json['driver_wallet'] == null
          ? null
          : DriverWallet.fromJson(
              json['driver_wallet'],
            ),
      setting: json['driver_settings'] == null
          ? null
          : DriverSetting.fromJson(
              json['driver_settings'],
            ),
    );
  }
}

class DriverSetting {
  final String? id;
  final bool? ride;
  final int? ridePrice;
  final bool? delivery;
  final int? deliveryPrice;
  final bool? food;
  final int? foodPrice;
  final bool? mart;
  final int? martPrice;
  final bool? autoBid;

  DriverSetting({
    this.id,
    this.ride,
    this.ridePrice,
    this.delivery,
    this.deliveryPrice,
    this.food,
    this.foodPrice,
    this.mart,
    this.martPrice,
    this.autoBid,
  });

  factory DriverSetting.fromJson(Map<String, dynamic> json) {
    return DriverSetting(
      id: json['id'],
      ride: json['ride'],
      ridePrice: json['ride_price'],
      delivery: json['delivery'],
      deliveryPrice: json['delivery_price'],
      food: json['food'],
      foodPrice: json['food_price'],
      mart: json['mart'],
      martPrice: json['mart_price'],
      autoBid: json['auto_bid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ride': ride,
      'ride_price': ridePrice,
      'delivery': delivery,
      'delivery_price': deliveryPrice,
      'food': food,
      'food_price': foodPrice,
      'mart': mart,
      'mart_price': martPrice,
      'auto_bid': autoBid,
    };
  }
}

class DriverWallet {
  final String? id;
  final int balance;

  DriverWallet({this.id, required this.balance});

  factory DriverWallet.fromJson(Map<String, dynamic> json) {
    return DriverWallet(
      id: json['id'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
    };
  }
}

class DriverDetail {
  final String id;

  DriverDetail({required this.id});

  factory DriverDetail.fromJson(Map<String, dynamic> json) {
    return DriverDetail(id: json['id']);
  }
}
