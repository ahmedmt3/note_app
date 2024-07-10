import 'package:flutter/material.dart';

import 'package:note_app/core/config/app_config.dart';
import 'package:note_app/model/image.dart';

class NoteImageWidget extends StatelessWidget {
  const NoteImageWidget({
    Key? key,
    required this.currImage,
  }) : super(key: key);

  final NoteImage currImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.network(
        "${AppConfig.imageRoot}${currImage.imageName}",
      ),
    );
  }
}
