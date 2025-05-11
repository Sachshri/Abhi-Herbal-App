import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String id;
  final String title;
  final String category;
  final String thumbnailUrl;
  final String content;
  final DateTime createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnailUrl,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'thumbnailUrl': thumbnailUrl,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      thumbnailUrl: map['thumbnailUrl'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory ArticleModel.empty() {
    return ArticleModel(
      id: '',
      title: '',
      category: '',
      thumbnailUrl: '',
      content: '',
      createdAt: DateTime.now(),
    );
  }
  factory ArticleModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return ArticleModel(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        category: data['category'] ?? '',
        thumbnailUrl: data['thumbnailUrl'] ?? '',
        content: data['content'] ?? '',
        createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      );
    } else {
      return ArticleModel.empty();
    }
  }
}
