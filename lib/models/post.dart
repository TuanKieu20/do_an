import 'package:do_an/models/category.dart';

class PostModel {
  int? id;
  String? content;
  int? userId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  PostModel(
      {this.id,
      this.content,
      this.userId,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 1;
    content = json['content'] ?? "";
    userId = json['user_id'] ?? 1;
    categoryId = json['category_id'] ?? 1;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = Category.fromJson(json['category']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category'] = category;
    return data;
  }
}
