import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class Promotion {
  final String message;
  final PromotionDataContainer data;
  final bool success;
  final int code;

  Promotion({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      message: json['message'],
      data: PromotionDataContainer.fromJson(json['data']),
      success: json['success'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
      'success': success,
      'code': code,
    };
  }
}

class PromotionDataContainer {
  final PaginationMeta paginationMeta;
  final List<PromotionData> data;

  PromotionDataContainer({
    required this.paginationMeta,
    required this.data,
  });

  factory PromotionDataContainer.fromJson(Map<String, dynamic> json) {
    return PromotionDataContainer(
      paginationMeta: PaginationMeta.fromJson(json['pagination_meta']),
      data: (json['data'] as List).map((e) => PromotionData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagination_meta': paginationMeta.toJson(),
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class PaginationMeta {
  final int currentPage;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;
  final bool canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
    required this.canLoadMore,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
      canLoadMore: json['can_load_more'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
      'can_load_more': canLoadMore,
    };
  }
}



class PromotionData {
  final dynamic id;
  final dynamic user;
  final TalkamPost? post;
  final TalkamGroup? group;
  final String? state;
  final String? country;
  final dynamic minAge;
  final dynamic maxAge;
  final dynamic gender;
  final dynamic dailyBudget;
  final dynamic? frequency;
  final dynamic duration;
  final dynamic status;
  final String? estimatedReach;
  final String? totalReach;
  final dynamic createdAt;
  final dynamic updatedAt;

  PromotionData({
    required this.id,
    required this.user,
    this.post,
    this.group,
    this.state,
    this.country,
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.dailyBudget,
    this.frequency,
    required this.duration,
    required this.status,
    this.estimatedReach,
    this.totalReach,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PromotionData.fromJson(Map<String, dynamic> json) {
    return PromotionData(
      id: json['id'],
      user:json['user']==null?null: User.fromJson(json['user']),
      post: json['post'] != null ? TalkamPost.fromJson(json['post']) : null,
      group: json['group'] != null ? TalkamGroup.fromJson(json['group']) : null,
      state: json['state'],
      country: json['country'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      gender: json['gender'],
      dailyBudget: json['daily_budget'],
      frequency: json['frequency'],
      duration: json['duration'],
      status
          : json['status'],
      estimatedReach: json['estimated_reach'],
      totalReach: json['total_reach'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'post': post?.toJson(),
      'group': group?.toString(),
      'state': state,
      'country': country,
      'min_age': minAge,
      'max_age': maxAge,
      'gender': gender,
      'daily_budget': dailyBudget,
      'frequency': frequency,
      'duration': duration,
      'status': status,
      'estimated_reach': estimatedReach,
      'total_reach': totalReach,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  bool get isActive => status.toString().toLowerCase() == "active";
  bool get isPost => post!=null;
}

class User {
  final int id;
  final String avatar;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'username': username,
      'email': email,
    };
  }


}



