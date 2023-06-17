import 'package:interview_test/app/constants/url_resources.dart';
import 'package:http/http.dart' as http;

class DogController {
  getRandomDogImages() async {
    const url = UrlResources.dogImageUrl;
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
