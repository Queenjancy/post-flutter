import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'dart:convert';

import './bloc.dart';
import '../models/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState>{

  PostBloc();

  PostProvider postProvider;
  Client client = Client();

  @override
  get initialState => PostUnloaded();

  @override
  Stream<PostState> mapEventToState(event) async* {
    print(event);
    if (event is Fetch) {
      if (state is PostLoadError) {
        yield PostUnloaded();
      } else if (state is PostUnloaded) {
        try {
          final posts = await _fetchPosts();
          yield PostLoaded(posts: posts);
        } catch (e) {
          print(e);
          yield PostLoadError();
        }
      }
    }
  }

  Future<List<Post>> _fetchPosts() async {
    final response = await client.get('https://aa5a33f8.ngrok.io/api/post');
    if (response.statusCode == 200) {
      print(response);
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          content: rawPost['content'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }

}

class PostProvider {
  Client client;

  // Future<List<Post>> fetchPosts() async {
  //   print('a');
  //   final response = await client.get(
  //       'https://4d750e90.ngrok.io/api/post');
  //   if (response.statusCode == 200) {
  //     print(response);
  //     final data = json.decode(response.body) as List;
  //     return data.map((rawPost) {
  //       return Post(
  //         id: rawPost['id'],
  //         title: rawPost['title'],
  //         content: rawPost['content'],
  //       );
  //     }).toList();
  //   } else {
  //     throw Exception('error fetching posts');
  //   }
  // }

}