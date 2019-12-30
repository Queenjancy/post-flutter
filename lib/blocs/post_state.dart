import 'package:equatable/equatable.dart';

import 'package:post_flutter/models/post_model.dart';

class PostState {

  PostState();

  @override
  List<Object> get props => [];
  
}

class PostUnloaded extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded({ this.posts });

  PostLoaded copyWith({ List<Post> posts }) {
    return PostLoaded(posts: posts ?? this.posts);
  }

  @override
  List<Object> get props => [ posts ];
}

class PostLoadError extends PostState {}