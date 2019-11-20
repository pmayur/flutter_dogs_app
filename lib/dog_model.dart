import 'dart:convert';
import 'dart:io';

class Dog {
  final String name;
  final String location;
  final String description;
  String imageUrl;

  // Default rating is 10
  int rating = 10;

  Future getImageUrl() async {
    // Null check to avoid extra work.
    if (imageUrl != null) {
      return;
    }

    // http calls are in flutter:
    HttpClient http = HttpClient();

    try {
      // Dart's URI builder
      var uri = Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      /* The API returns a JSON object with a property
      called 'message', which actually is the URL. */
      imageUrl = json.decode(responseBody)['message'];
    } catch (exception) {
      print(exception);
    }
  }

  // Dog class instantiation
  Dog(this.name, this.location, this.description);
}