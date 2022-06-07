import 'dart:convert';

import 'package:flutter_tv_shows/data/models/shows_list_response.dart';

const successGetMoviesData = {
  "shows": [
    {
      "id": "198",
      "average_rating": 4,
      "description":
          "In April 1986, an explosion at the Chernobyl nuclear power plant in the Union of Soviet Socialist Republics becomes one of the world's worst man-made catastrophes.",
      "image_url":
          "https://s3.eu-central-1.amazonaws.com/tv-shows.infinum.academy/uploads/2161c0a73d80c10bcaacf0fb5486b532.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA5B57LC7FGJ7IBYFB%2F20220607%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20220607T175439Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=6788b48d172d6b722f9c48b6d0fd33b09afd467c9ac8bc7b62555360be5ce661",
      "no_of_reviews": 2,
      "title": "Chernobyl"
    }
  ],
  "meta": {
    "pagination": {"count": 100, "page": 5, "items": 20, "pages": 5}
  }
};

var showListResponse =
    ShowsListResponse.fromJson(json.decode(json.encode(successGetMoviesData)));
