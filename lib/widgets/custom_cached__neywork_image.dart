import 'package:bursa_flutter/widgets/loading_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../consts/app_images.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomCachedNetworkImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => const LoadingProgressWidget(
        color: Colors.blue,
      ),
      errorWidget: (context, url, error) => SvgPicture.asset(
        AppImages.blankImg,
        fit: BoxFit.fill,
      ),
    );
  }
}
