class HomeDataModel {
  final List<String> bannerImages;
  final List<SectionImageModel> sectionImages;
  final List<ProductModel> topSelling;
  final List<CollectionModel> collection;
  final List<ProductModel> outdoorCollection;

  HomeDataModel({
    required this.bannerImages,
    required this.sectionImages,
    required this.topSelling,
    required this.collection,
    required this.outdoorCollection,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      bannerImages: List<String>.from(json['bannerImages'] ?? []),
      sectionImages: (json['sectionImages'] as List<dynamic>?)
              ?.map((e) => SectionImageModel.fromJson(e))
              .toList() ??
          [],
      topSelling: (json['topSelling'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      collection: (json['collection'] as List<dynamic>?)
              ?.map((e) => CollectionModel.fromJson(e))
              .toList() ??
          [],
      outdoorCollection: (json['outdoorCollection'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SectionImageModel {
  final String image;
  final String title;

  SectionImageModel({required this.image, required this.title});

  factory SectionImageModel.fromJson(Map<String, dynamic> json) {
    return SectionImageModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class ProductModel {
  final String image;
  final String choice;
  final String title;
  final String price;
  final String rating;

  ProductModel({
    required this.image,
    required this.choice,
    required this.title,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json['image'] ?? '',
      choice: json['choice'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}

class CollectionModel {
  final String image;
  final String title;

  CollectionModel({required this.image, required this.title});

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
