class LoginResponse {
  final String token, accessToken, refreshToken;

  LoginResponse({
    required this.token,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json["token"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );
}
