import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/utils/validators.dart';

void main() {
  test('isPasswordValid returns true when password is not empty', () {
    expect(true, isPasswordValid('123'));
  });

  test('isPasswordValid returns false when password is empty', () {
    expect(false, isPasswordValid(''));
  });

  test('isEmailValid returns true when email provided is a valid email', () {
    expect(true, isEmailValid('test@gmail.com'));
  });

  test('isEmailValid returns false when email provided is a not a valid email',
      () {
    expect(false, isEmailValid('test'));
  });
}
