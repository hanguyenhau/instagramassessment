import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/post/models/post.dart';
import 'package:instagram_assessment/states/post/provider/all_posts_provider.dart';
import 'package:instagram_assessment/views/view/post/post_details_view.dart';

class PostsSliverListView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverListView({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      
    },);
  }
}
