import 'package:github_search/models/issue.dart';
import 'package:github_search/models/repo.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'dart:convert' as convert;

Future<List<MUser>> getUserData(String search) async {
  var url = Uri.https('api.github.com', '/search/users', {'q': search});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<MUser> userData = [];
    for (int i = 0; i < jsonResponse['items'].length; i++) {
      userData.add(MUser(
          username: jsonResponse['items'][i]['login'],
          imageURL: jsonResponse['items'][i]['avatar_url']));
    }
    return userData;
  } else {
    return [];
  }
}

Future<List<MRepo>> getRepoData(String search) async {
  var url = Uri.https('api.github.com', '/search/repositories', {'q': search});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<MRepo> repoData = [];
    for (int i = 0; i < jsonResponse['items'].length; i++) {
      repoData.add(MRepo(
          title: jsonResponse['items'][i]['name'],
          date: jsonResponse['items'][i]['created_at'],
          watchers: jsonResponse['items'][i]['watchers_count'],
          stars: jsonResponse['items'][i]['stargazers_count'],
          forks: jsonResponse['items'][i]['forks_count'],
          imageURL: jsonResponse['items'][i]['owner']['avatar_url']));
    }
    return repoData;
  } else {
    return [];
  }
}

Future<List<MIssue>> getIssueData(String search) async {
  var url = Uri.https('api.github.com', '/search/issues', {'q': search});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<MIssue> issueData = [];
    for (int i = 0; i < jsonResponse['items'].length; i++) {
      issueData.add(MIssue(
          title: jsonResponse['items'][i]['title'],
          date: jsonResponse['items'][i]['updated_at'],
          state: jsonResponse['items'][i]['state'],
          imageURL: jsonResponse['items'][i]['user']['avatar_url']));
    }
    return issueData;
  } else {
    return [];
  }
}
