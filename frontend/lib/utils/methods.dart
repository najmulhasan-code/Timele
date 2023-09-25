import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/api.dart';
import 'package:frontend/models.dart';

class HelperFunction{
  //Get function
  Future<List<dynamic>>  fetchData() async {
    List<Paragraph> post =[];
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);

      data.forEach((models) {
        Paragraph para = Paragraph(
          id: models['id'],
          title: models['title'],
          description: models['description'],
        );

        post.add(para);
      });
      print(post.length);
      return post;

    } catch (e) {
      print('Error is $e');
    }
    return post;
  }


  //Send data to backend
  Future<void> postData({String title = "", String description = ""}) async {
    if(title.isNotEmpty || description.isNotEmpty){
      return;
    }
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "description": description,
        }),
      );
      if (response.statusCode == 201) {
        fetchData();
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }


  //Delete function
  Future<void> deletePost(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + "/" + id));
      fetchData();
    } catch (e) {
      print(e);
    }
  }

}

