// To parse this JSON data, do
//
//     final userSearchResponse = userSearchResponseFromJson(jsonString);

import 'dart:convert';

UserSearchResponse userSearchResponseFromJson(String str) => UserSearchResponse.fromJson(json.decode(str));

String userSearchResponseToJson(UserSearchResponse data) => json.encode(data.toJson());

class UserSearchResponse {
  String message;
  Data data;
  bool success;
  int code;

  UserSearchResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UserSearchResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      UserSearchResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) => UserSearchResponse(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "success": success,
    "code": code,
  };
}

class Data {
  UserPaginationMeta paginationMeta;
  List<UserSearchResult> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    UserPaginationMeta? paginationMeta,
    List<UserSearchResult>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paginationMeta: UserPaginationMeta.fromJson(json["pagination_meta"]),
    data: List<UserSearchResult>.from(json["data"].map((x) => UserSearchResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination_meta": paginationMeta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserSearchResult {
  int id;
  dynamic? avatar;
  dynamic name;
  dynamic email;
  dynamic role;
  dynamic age;
  dynamic username;
  dynamic googleId;
  dynamic facebookId;
  dynamic tiktokId;
  dynamic appleId;
  dynamic isBlocked;
  dynamic iAmBlocked;
  dynamic status;
  dynamic gender;
  dynamic anonymousPost;
  dynamic anonymousComment;
  dynamic publicGroupCount;
  dynamic? dateOfBirth;
  dynamic shouldDisplayAds;
  dynamic pricingCurrency;
  dynamic activeSubscription;
  State? state;
  Country? country;
  List<Interest> interests;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;

  UserSearchResult({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.role,
    required this.age,
    required this.username,
    required this.googleId,
    required this.facebookId,
    required this.tiktokId,
    required this.appleId,
    required this.isBlocked,
    required this.iAmBlocked,
    required this.status,
    required this.gender,
    required this.anonymousPost,
    required this.anonymousComment,
    required this.publicGroupCount,
    required this.dateOfBirth,
    required this.shouldDisplayAds,
    required this.pricingCurrency,
    required this.activeSubscription,
    required this.state,
    required this.country,
    required this.interests,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  UserSearchResult copyWith({
    int? id,
    String? avatar,
    String? name,
    String? email,
    String? role,
    dynamic age,
    String? username,
    dynamic googleId,
    dynamic facebookId,
    dynamic tiktokId,
    dynamic appleId,
    bool? isBlocked,
    bool? iAmBlocked,
    String? status,
    String? gender,
    int? anonymousPost,
    int? anonymousComment,
    int? publicGroupCount,
    DateTime? dateOfBirth,
    int? shouldDisplayAds,
    String? pricingCurrency,
    dynamic activeSubscription,
    State? state,
    Country? country,
    List<Interest>? interests,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserSearchResult(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        age: age ?? this.age,
        username: username ?? this.username,
        googleId: googleId ?? this.googleId,
        facebookId: facebookId ?? this.facebookId,
        tiktokId: tiktokId ?? this.tiktokId,
        appleId: appleId ?? this.appleId,
        isBlocked: isBlocked ?? this.isBlocked,
        iAmBlocked: iAmBlocked ?? this.iAmBlocked,
        status: status ?? this.status,
        gender: gender ?? this.gender,
        anonymousPost: anonymousPost ?? this.anonymousPost,
        anonymousComment: anonymousComment ?? this.anonymousComment,
        publicGroupCount: publicGroupCount ?? this.publicGroupCount,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        shouldDisplayAds: shouldDisplayAds ?? this.shouldDisplayAds,
        pricingCurrency: pricingCurrency ?? this.pricingCurrency,
        activeSubscription: activeSubscription ?? this.activeSubscription,
        state: state ?? this.state,
        country: country ?? this.country,
        interests: interests ?? this.interests,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserSearchResult.fromJson(Map<String, dynamic> json) => UserSearchResult(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    age: json["age"],
    username: json["username"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    tiktokId: json["tiktok_id"],
    appleId: json["apple_id"],
    isBlocked: json["is_blocked"],
    iAmBlocked: json["i_am_blocked"],
    status: json["status"],
    gender: json["gender"],
    anonymousPost: json["anonymous_post"],
    anonymousComment: json["anonymous_comment"],
    publicGroupCount: json["public_group_count"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    shouldDisplayAds: json["should_display_ads"],
    pricingCurrency: json["pricing_currency"],
    activeSubscription: json["active_subscription"],
    state: json["state"] == null ? null : State.fromJson(json["state"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    interests: List<Interest>.from(json["interests"].map((x) => Interest.fromJson(x))),
    emailVerifiedAt: json["email_verified_at"] == null?null: DateTime.parse(json["email_verified_at"]),
    createdAt: json["created_at"] == null?null:DateTime.parse(json["created_at"]),
    updatedAt:json["updated_at"] == null?null: DateTime.parse(json["updated_at"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "email": email,
    "role": role,
    "age": age,
    "username": username,
    "google_id": googleId,
    "facebook_id": facebookId,
    "tiktok_id": tiktokId,
    "apple_id": appleId,
    "is_blocked": isBlocked,
    "i_am_blocked": iAmBlocked,
    "status": status,
    "gender": gender,
    "anonymous_post": anonymousPost,
    "anonymous_comment": anonymousComment,
    "public_group_count": publicGroupCount,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "should_display_ads": shouldDisplayAds,
    "pricing_currency": pricingCurrency,
    "active_subscription": activeSubscription,
    "state": state?.toJson(),
    "country": country?.toJson(),
    "interests": List<dynamic>.from(interests.map((x) => x.toJson())),
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Country {
  dynamic id;
  dynamic name;

  Country({
    required this.id,
    required this.name,
  });

  Country copyWith({
    int? id,
    String? name,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Interest {
  dynamic id;
  dynamic name;
  DateTime createdAt;

  Interest({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  Interest copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) =>
      Interest(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
  };
}

class State {
  dynamic id;
  dynamic name;
  dynamic countryId;

  State({
    required this.id,
    required this.name,
    required this.countryId,
  });

  State copyWith({
    int? id,
    String? name,
    int? countryId,
  }) =>
      State(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
      );

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}

class UserPaginationMeta {
  dynamic currentPage;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;
  dynamic canLoadMore;

  UserPaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  UserPaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      UserPaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory UserPaginationMeta.fromJson(Map<String, dynamic> json) => UserPaginationMeta(
    currentPage: json["current_page"],
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
    canLoadMore: json["can_load_more"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
    "can_load_more": canLoadMore,
  };
}
