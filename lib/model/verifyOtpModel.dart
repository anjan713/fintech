class VerifyOtpModel {
  final String accessToken;
  final bool newUser;
  final String result;
  final String segment;
  final String sendBranch;

  VerifyOtpModel.fromJson(Map json)
      : accessToken = json['access_token'],
        newUser = json['new_user'],
        result = json['result'],
        segment = json['segment'],
        sendBranch = json['send_branch'];
}
