import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'common.dart';
import 'dart:math' as math;

Widget failImage({double height, double width}) => LayoutBuilder(
      builder: (BuildContext context, containts) {
        Size size = containts.biggest;
        double mWidth = width ?? size.width;
        double mHeight = height ?? size.height;
        double minSize = math.min(mWidth, mHeight);
        return Center(
          child: SvgImageView(
            assets: "svgs/loading_i2.svg",
            width: minSize,
            height: minSize,
            fit: BoxFit.contain,
          ),
        );
      },
    );

typedef ImageLoadStateChanged = Function(ExtendedImageState state);

//手动封装一个view
class ImageView extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final Widget placeholder;
  final BoxFit fit;
  final ImageLoadStateChanged loadStateChanged;

  const ImageView({
    Key key,
    this.url,
    this.width,
    this.height,
    this.placeholder,
    this.fit,
    this.loadStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == null || url == 'null' || url.isEmpty
        ? (placeholder ??
            SizedBox(
              width: width,
              height: height,
              child: failImage(width: width, height: height),
            ))
        : ExtendedImage.network(
            url.startsWith('http') ? url : BaseConfig.httpBase.getOssUrl(url),
            width: width,
            height: height,
            fit: fit,
            cache: true,
            retries: 3,
            enableLoadState: true,
            loadStateChanged: (ExtendedImageState state) {
              if (loadStateChanged != null) {
                loadStateChanged(state);
              }
              if (state.extendedImageLoadState == LoadState.loading ||
                  state.extendedImageLoadState == LoadState.failed) {
                return failImage(width: width, height: height);
              } else {
                return state.completedWidget;
              }
            },
          );
  }

  Widget _buildFrame(BuildContext context, Widget child, int frame,
      bool wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) return child;
    if (frame == null)
      return SizedBox(
        width: width,
        height: height,
        child: failImage(width: width, height: height),
      );
    return AnimatedOpacity(
      child: child,
      opacity: frame == null ? 0 : 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
}

//圆形图片
class CircleImageView extends StatelessWidget {
  final String url;
  final double radius;
  final String assetsPlaceholder;

  const CircleImageView(
      {Key key,
      @required this.url,
      @required this.radius,
      this.assetsPlaceholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: url != null && url != 'null' && url.isNotEmpty
          ? ExtendedNetworkImageProvider(
              url.startsWith('http') ? url : BaseConfig.httpBase.getImage(url),
              cache: true)
          : AssetImage(assetsPlaceholder ?? 'assets/mine/avatar_no.png'),
    );
  }
}

//svg资源文件
class SvgImageView extends StatefulWidget {
  final String assets;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;

  const SvgImageView(
      {Key key, this.assets, this.color, this.width, this.height, this.fit})
      : super(key: key);

  @override
  _SvgImageViewState createState() => _SvgImageViewState();
}
class _SvgImageViewState extends State<SvgImageView> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/${widget.assets}',
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      color: widget.color,
    );
  }

  @override
  void didUpdateWidget(SvgImageView oldWidget) {
    if (oldWidget.key != widget.key ||
        oldWidget.width != widget.width ||
        oldWidget.height != widget.height ||
        widget.color != oldWidget.color ||
        oldWidget.fit != widget.fit ||
        oldWidget.assets != widget.assets) super.didUpdateWidget(oldWidget);
  }
}


//资源图片
class AssetImageView extends StatefulWidget {
  final String assets;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;

  const AssetImageView(
      {Key key, this.assets, this.color, this.width, this.height, this.fit})
      : super(key: key);

  @override
  _AssetImageViewState createState() => _AssetImageViewState();
}

class _AssetImageViewState extends State<AssetImageView> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/${widget.assets}',
      width: widget.width,
      alignment: Alignment.center,
      height: widget.height,
      fit: widget.fit,
      filterQuality: FilterQuality.medium,
      color: widget.color,
    );
  }

  @override
  void didUpdateWidget(AssetImageView oldWidget) {
    if (oldWidget.key != widget.key ||
        oldWidget.width != widget.width ||
        oldWidget.height != widget.height ||
        widget.color != oldWidget.color ||
        oldWidget.fit != widget.fit ||
        oldWidget.assets != widget.assets) super.didUpdateWidget(oldWidget);
  }
}
