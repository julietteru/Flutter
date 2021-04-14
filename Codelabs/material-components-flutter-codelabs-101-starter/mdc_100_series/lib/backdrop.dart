import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';

const double _kFlingVelocity = 2.0;

class BackDrop extends StatefulWidget {
  final Category category;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const BackDrop(
      {@required this.category,
      @required this.frontLayer,
      @required this.backLayer,
      @required this.frontTitle,
      @required this.backTitle})
      : assert(category != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  State<StatefulWidget> createState() => BackDropState();
}

class BackDropState extends State<BackDrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'backdrop');

  AnimationController _animationController;

  @override
  void didUpdateWidget(BackDrop old) {
    super.didUpdateWidget(old);

    if (widget.category != old.category) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _animationController.fling(velocity: _kFlingVelocity);
    }
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _animationController.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animationController.view);

    return Stack(
      key: _backdropKey,
      children: [
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
            rect: layerAnimation,
            child: FrontLayer(
              child: widget.frontLayer,
              onTap: _toggleBackdropLayerVisibility,
            )),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: _BackdropTitle(s
      listenable: _animationController.view,
      onPress: _toggleBackdropLayerVisibility,
      frontTitle: widget.frontTitle,
      backTitle: widget.backTitle,
    ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'tune',
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 300), vsync: this, value: 1.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}

class FrontLayer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  FrontLayer({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Container(
                height: 40,
                alignment: AlignmentDirectional.centerStart,
              )),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.headline6,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(1.0, 0.0),
                ).evaluate(animation),
                child: ImageIcon(AssetImage('assets/diamond.png')),
              )]),
          ),
        ),
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0.5, 0.0),
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: frontTitle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

