class Item {
  Item(
      {this.id,
      this.name,
      this.photo,
      this.quantity,
      this.expiryDate,
      this.description,
      this.userLocation,
      this.userPhoneNumber,
      this.userName,
      this.categoryId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        name: json['name'],
        photo: json['photo'],
        quantity: json['quantity'],
        expiryDate: DateTime.parse(json['expiry_date']),
        description: json['description'],
        userLocation: json['user']['location'],
        userPhoneNumber: json['user']['phone_no'],
        userName: json['user']['name'],
        categoryId: json['category']['id']);
  }

  final int id;
  final String name;
  final String photo;
  final String quantity;
  final DateTime expiryDate;
  final String description;
  final String userLocation;
  final String userPhoneNumber;
  final String userName;
  final int categoryId;
}
