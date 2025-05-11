import 'package:new_flutter_app/common/widgets/custom_shapes/containers/curved_edge_container.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_circular_container.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderWidget extends StatelessWidget {
  const PrimaryHeaderWidget({
    super.key,
    required this.child,
    this.showImage = true,
  });
  final Widget child;
  final bool showImage;
  @override
  Widget build(BuildContext context) {
    return ClipPathContainer(
      child: Container(
        color: ColorConstants.primary,
        child: Stack(
          children: [
            if (showImage)
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Image(
                  image: AssetImage(ImageStringsConstants.primaryImage),
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              top: -150,
              right: -250,
              child: CustomCircularContainer(
                radius: 400,
                height: 400,
                width: 400,
                color:
                    showImage
                        ? Color.fromRGBO(0, 255, 0, 0.2)
                        : Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ),
            Positioned(
              bottom: -150,
              right: -300,
              child: CustomCircularContainer(
                radius: 400,
                height: 400,
                width: 400,
                color:
                    showImage
                        ? Color.fromRGBO(0, 255, 0, 0.2)
                        : Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
