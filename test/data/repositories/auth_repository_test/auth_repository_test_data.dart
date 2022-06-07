import 'package:flutter_tv_shows/data/models/login_user_request.dart';
import 'package:flutter_tv_shows/data/models/user.dart';
import 'package:flutter_tv_shows/data/models/user_session_data.dart';

const user = User(
  id: '1',
  email: 'test@gmail.com',
  imageUrl: 'test.png',
);

final loginUser = LoginUserRequest(email: 'test@gmail.com', password: '1234');

final successUserLoginResponse = {
  "user": {"id": "1", "email": "test@gmail.com", "image_url": "test.png"}
};

final errorUserLoginResponse = {
  {
    "success": false,
    "errors": ["Invalid login credentials. Please try again."]
  }
};

final userSessionData = UserSessionData(
  accessToken: 'access-token',
  client: 'client',
  tokenType: 'token-type',
  uid: 'uid',
);
