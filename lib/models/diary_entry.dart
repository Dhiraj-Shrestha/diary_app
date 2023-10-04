// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class DiaryEntry {
  String? title;

  String? price;
  String? description;

  String? image;
  String? category;

  DiaryEntry({
    this.title,
    this.price,
    this.description,
    this.image,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      title: map['title'] != null ? map['title'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryEntry.fromJson(String source) =>
      DiaryEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiaryEntry(title: $title, price: $price, description: $description, image: $image, category: $category)';
  }

  @override
  bool operator ==(covariant DiaryEntry other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.price == price &&
        other.description == description &&
        other.image == image &&
        other.category == category;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        price.hashCode ^
        description.hashCode ^
        image.hashCode ^
        category.hashCode;
  }
}
