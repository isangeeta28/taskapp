class Product {
  final String id;
  final String name;
  final String desc;
  final String longDesc;
  final String category;
  final String tag;
  final int price;
  final String sku;
  final String collectionId;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.longDesc,
    required this.category,
    required this.tag,
    required this.price,
    required this.sku,
    required this.collectionId,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['Name'],
      desc: json['Desc'],
      longDesc: json['LongDesc'],
      category: json['Category'],
      tag: json['tag'],
      price: json['Price'],
      sku: json['SKU'],
      collectionId: json['collectionId'],
      image: json['image'],
    );
  }

  String get fullImageUrl {
    return 'https://interview.gdev.gosbfy.com/api/files/$collectionId/$id/$image';
  }
}
