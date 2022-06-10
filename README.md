
# Tv shows

A simple tv show app built with flutter.

## Architecture

Bloc architecture is a Model-View-ViewModel architecture that removes the tight coupling between each component.

![Bloc](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_architecture.png)

## Internationalization

This project follows the official guideline for internalization which can be found here https://docs.flutter.dev/development/accessibility-and-localization/internationalization, the current supported languages are Croatian and English. The arb files can be found at lib/I10n/


## Testing
I have implemented unit and bloc tests which can be found under /tests directory.
You can use the following command to run the tests.

    flutter test
   

## SCREENSHOTS <p float="left">

<p>

<img  src="https://user-images.githubusercontent.com/14147462/173116950-edf13c8d-b105-4382-ac48-967f792cfc83.png"  width="200"  />

<img  src="https://user-images.githubusercontent.com/14147462/173117040-2b4724ab-ea44-42f7-a025-9463b4149bf3.png"  width="200"  />

<img  src="https://user-images.githubusercontent.com/14147462/173117107-c61a2d30-01fe-4d5e-b771-de2c725095ed.png"  width="200"  />

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

* [Flutter svg](https://pub.dev/packages/flutter_svg)- An SVG rendering and widget library for Flutter, which allows painting and displaying Scalable Vector Graphics 1.1 files.