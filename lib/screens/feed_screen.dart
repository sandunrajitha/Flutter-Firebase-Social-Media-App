import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset('assets/logo.svg',
            colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            height: 25),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.messenger_outline),
          )
        ],
      ),
      body: PostCard(),
    );
  }
}
