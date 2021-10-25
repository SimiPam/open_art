import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/dims.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:open_art/shared/widgets/action_button.dart';
import 'package:open_art/shared/widgets/space.dart';

class UnsupportedDeviceScreen extends StatelessWidget {
  const UnsupportedDeviceScreen(this.media);

  final MediaQueryData media;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dims.deviceSize.width + (media.padding.left + media.padding.right),
      height:
          Dims.deviceSize.height + (media.padding.top + media.padding.bottom),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Styles.bold(
            'Unsupported',
            fontSize: Dims.dx(30),
            color: Colors.red,
          ),
          VSpace(Dims.dx(20)),
          Container(
            width: Dims.percentWidth(Dims.deviceSize.width > 500 ? 50 : 80),
            child: Styles.semiBold(
              'Oops!! We\'re unable to render this application on your device due to screen size and/or device capacity limitations.',
              color: Colors.black,
              align: TextAlign.center,
              fontSize: Dims.dx(14),
            ),
          ),
          VSpace(Dims.dx(50)),
          Container(
            width: Dims.dx(200),
            child: ActionButton(
              text: 'Learn more',
              clicked: () {
                print('Learn more...');
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
