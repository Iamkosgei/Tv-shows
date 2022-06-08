import 'dart:convert';

import 'package:flutter_tv_shows/data/models/user.dart';

const user = User(
  id: '1',
  email: 'test@gmail.com',
  imageUrl: 'test.png',
);

final userStr = jsonEncode(user.toJson());
