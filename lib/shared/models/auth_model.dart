class AuthPayload {
  AuthPayload({
    this.id,
    this.token,
    this.updatedAt,
    this.refreshToken,
    this.refreshedAt,
  });

  factory AuthPayload.fromJson(dynamic json,
      [DateTime updated, DateTime refreshed]) {
    if (json == null) {
      return null;
    }

    int updateTime = DateTime.now().millisecondsSinceEpoch;
    if (updated != null) {
      updateTime = updated.millisecondsSinceEpoch;
    } else if (json['updatedAt'] != null) {
      updateTime = json['updatedAt'] as int;
    }

    int refreshTime = DateTime.now().millisecondsSinceEpoch;
    if (refreshed != null) {
      refreshTime = refreshed.millisecondsSinceEpoch;
    } else if (json['refreshedAt'] != null) {
      refreshTime = json['refreshedAt'] as int;
    }

    return AuthPayload(
      id: json['id'] as String,
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
      updatedAt: updateTime,
      refreshedAt: refreshTime,
    );
  }

  String id;
  String token;
  String refreshToken;
  int updatedAt; // milliseconds since epoch
  int refreshedAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'token': token,
      'updatedAt': updatedAt,
      'refresh_token': refreshToken,
      'refreshedAt': refreshedAt,
    };
  }
}
