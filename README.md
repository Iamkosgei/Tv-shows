
  

# Tv shows

  

A simple tv show app built with flutter.

  

## Architecture

  

Bloc architecture is a Model-View-ViewModel architecture that removes the tight coupling between each component.

  

![Bloc](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_architecture.png)

  

## Internationalization

This project follows the official guideline for internalization which can be found here https://docs.flutter.dev/development/accessibility-and-localization/internationalization, the current supported languages are Croatian and English. The arb files can be found at lib/I10n/

    lib/l10n/app_en.arb
     {
    
    "tvShow": "Tv show",
    
    "@tvShow": {
    
    "description": "Tv show"
    },


.     

    lib/l10n/app_hr.arb
     {

	"tvShow": "TV emisije",
	}



## Testing

I have implemented unit and bloc tests which can be found under /tests directory.

You can use the following command to run the tests.

  

flutter test

  

## SCREENSHOTS <p  float="left">

  

<p>

  

<img  src="https://user-images.githubusercontent.com/14147462/173116950-edf13c8d-b105-4382-ac48-967f792cfc83.png"  width="200" />

  

<img  src="https://user-images.githubusercontent.com/14147462/173117040-2b4724ab-ea44-42f7-a025-9463b4149bf3.png"  width="200" />

  

<img  src="https://user-images.githubusercontent.com/14147462/173117107-c61a2d30-01fe-4d5e-b771-de2c725095ed.png"  width="200" />

  

</p>

  

## API

  

API documentation is available here - https://tv-shows.infinum.academy/api/v1/docs/index.html

  

## Tech-stack

  

* Tech-stack

  

* [Dart](https://dart.dev/) - Dart is the programming language used to code Flutter apps. Dart is another product by Google and released version 2.1, before Flutter, in November.

  

* [Flutter](https://flutter.dev/) - Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, Web platform, and the web from a single codebase.

  

* [Bloc](https://bloclibrary.dev/#/) - A predictable state management library for Dart.

  

* [Dio](https://pub.dev/packages/dio) - A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.

  

* [Get it](https://pub.dev/packages/get_it) - This is a simple Service Locator for Dart and Flutter projects.

  

* [Pretty Dio Logger](https://pub.dev/packages/pretty_dio_logger) - Pretty Dio logger is a Dio interceptor that logs network calls in a pretty, easy to read format.

  

* [Equatable](https://pub.dev/packages/equatable) - A Dart package that helps to implement value based equality without needing to explicitly override == and hashCode.

  

* [Flutter Secure Storage](https://pub.dev/packages/fade_shimmer) - Flutter Secure Storage provides API to store data in secure storage. Keychain is used in iOS, KeyStore based solution is used in Android.

  

* [Fade Shimmer](https://pub.dev/packages/flutter_secure_storage) - A fade shimmer library to implement loading like lastest facebook loading effect.

  

* [Fimber](https://pub.dev/packages/fimber) - Extensible logging for Flutter - based on Timber on Android, using similar (as far as Dart lang allows) method API with same concepts for tree and planting logging tree.

  

* [intl](https://pub.dev/packages/intl) - Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.

  

* [Cached Network Image](https://pub.dev/packages/cached_network_image) - Flutter library to load and cache network images. Can also be used with placeholder and error widgets.

  

* [Mockito](https://pub.dev/packages/mockito) - A mock framework inspired by Mockito with APIs for Fakes, Mocks, behavior verification, and stubbing.

  

* [Build Runner](https://pub.dev/packages/build_runner) - A build system for Dart code generation and modular compilation.

  

* [Bloc Test](https://pub.dev/packages/bloc_test) - A testing library which makes it easy to test blocs. Built to be used with the bloc state management package.

  

* [Flutter svg](https://pub.dev/packages/flutter_svg)- An SVG rendering and widget library for Flutter, which allows painting and displaying Scalable Vector Graphics 1.1 files.