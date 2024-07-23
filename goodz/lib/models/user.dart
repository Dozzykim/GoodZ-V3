class User {
  int? no;
  String? userId;
  String? username;
  String? nickname;
  String? password;
  String? birth;
  String? phoneNumber;
  String? profilePictureUrl;
  int? profileImgNo;
  String? account;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? enabled;
  List<UserAuth>? authList;
  List<User>? followList;
  int? countFollower;
  int? countFollowing;

  User({
    this.no,
    this.userId,
    this.username,
    this.nickname,
    this.password,
    this.birth,
    this.phoneNumber,
    this.profilePictureUrl,
    this.profileImgNo,
    this.account,
    this.createdAt,
    this.updatedAt,
    this.enabled,
    this.authList,
    this.followList,
    this.countFollower,
    this.countFollowing,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      no: json['no'],
      userId: json['userId'],
      username: json['username'],
      nickname: json['nickname'],
      password: json['password'],
      birth: json['birth'],
      phoneNumber: json['phoneNumber'],
      profilePictureUrl: json['profilePictureUrl'],
      profileImgNo: json['profileImgNo'],
      account: json['account'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      enabled: json['enabled'],
      authList: json['authList'] != null
          ? (json['authList'] as List<dynamic>)
              .map((authJson) => UserAuth.fromJson(authJson))
              .toList()
          : null,
      followList: json['followList'] != null
          ? (json['followList'] as List<dynamic>)
              .map((userJson) => User.fromJson(userJson))
              .toList()
          : null,
      countFollower: json['countFollower'],
      countFollowing: json['countFollowing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'userId': userId,
      'username': username,
      'nickname': nickname,
      'password': password,
      'birth': birth,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
      'profileImgNo': profileImgNo,
      'account': account,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'enabled': enabled,
      'authList': authList?.map((auth) => auth.toJson()).toList(),
      'followList': followList?.map((user) => user.toJson()).toList(),
      'countFollower': countFollower,
      'countFollowing': countFollowing,
    };
  }

  @override
  String toString() {
    return 'User{no: $no, userId: $userId, username: $username, nickname: $nickname, password: $password, birth: $birth, phoneNumber: $phoneNumber, profilePictureUrl: $profilePictureUrl, profileImgNo: $profileImgNo, account: $account, createdAt: $createdAt, updatedAt: $updatedAt, enabled: $enabled, authList: $authList, followList: $followList, countFollower: $countFollower, countFollowing: $countFollowing}';
  }
}

class UserAuth {
  int? authNo;
  String? userId;
  String? auth;

  UserAuth({
    this.authNo,
    this.userId,
    this.auth,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      authNo: json['authNo'],
      userId: json['userId'],
      auth: json['auth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authNo': authNo,
      'userId': userId,
      'auth': auth,
    };
  }

  @override
  String toString() {
    return 'UserAuth{authNo: $authNo, userId: $userId, auth: $auth}';
  }
}
