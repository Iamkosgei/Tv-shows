class UserSessionData {
  String? accessToken;
  String? client;
  String? tokenType;
  String? uid;

  UserSessionData({this.accessToken, this.client, this.tokenType, this.uid});

  UserSessionData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access-token'];
    client = json['client'];
    tokenType = json['token-type'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access-token'] = accessToken;
    data['client'] = client;
    data['token-type'] = tokenType;
    data['uid'] = uid;
    return data;
  }
}
