import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:interview_test/app/constants/url_resources.dart';
import 'package:interview_test/app/presentation/profile_screen/model/Profile_details_model.dart';

class ProfileController {
  Future<ProfileDetailsModel> getProfileDetails() async {
    const url = UrlResources.profileUrl;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log('profile response => ${response.body}');
        return ProfileDetailsModel.fromJson(json.decode(response.body));
      }
      return ProfileDetailsModel();
    } catch (e) {
      log('', error: e.toString());
      rethrow;
    }
  }
}
