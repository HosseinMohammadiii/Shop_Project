class ApiExeption implements Exception {
  int? code;
  String? message;
  ApiExeption(this.code, this.message) {
    if (code != 400) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
  }
}
