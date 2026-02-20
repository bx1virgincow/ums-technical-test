class ApiConstants {
  static const String baseurl = 'http://localhost:<port>/api';
  static const String loginEndpoint = '$baseurl/auth/login/verify/email';
  static const String registerEndpoint = '$baseurl/auth/register';
  static const String getUserInfoEndpoint = '$baseurl/user/info';
  static const String initiateUrl = '$baseurl/auth/login/initiate';
  static const String verifyOtpUrl = '$baseurl/auth/register/verify/email';
}
