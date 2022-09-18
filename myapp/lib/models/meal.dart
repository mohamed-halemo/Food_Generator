import 'dart:convert';

import 'package:equatable/equatable.dart';

class MealModel extends Equatable {
  String? id;
  final String categories;
  String name;
  final String image;
  bool? liked;
  MealModel({
    this.id,
    required this.categories,
    required this.name,
    required this.image,
  });

  MealModel copyWith({
    String? id,
    String? categories,
    String? name,
    String? image,
    bool? liked,
  }) {
    return MealModel(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json['id'].toString() as String,
        categories: json['categories'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
      );
    Map<String,dynamic> toJson() => {"categories": categories , "name": name, "image": image};
    
  @override
  List<Object?> get props => [
        id,
        categories,
        name,
        image,
      ];
}
