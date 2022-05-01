import 'package:flutter/material.dart';



const Duration _kExpand = Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    Key? key,

    this.backgroundColor,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.initiallyExpanded: false,
    this.title
  })
      : assert(initiallyExpanded != null),
        super(key: key);

  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget>? children;
  final Color? backgroundColor;
  final bool? initiallyExpanded;
  final Widget? title;

  @override
  AppExpansionTileState createState() =>  AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  CurvedAnimation? _easeOutAnimation;
  CurvedAnimation? _easeInAnimation;
  ColorTween? _borderColor;
  ColorTween? _headerColor;
  ColorTween? _iconColor;
  ColorTween? _backgroundColor;
  Animation<double>? _iconTurns;
  Widget? _title;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation =  CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    _easeInAnimation =  CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _borderColor =  ColorTween();
    _headerColor =  ColorTween();
    _iconColor =  ColorTween();
    _title=widget.title;
    _iconTurns =  Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation!);
    _backgroundColor =  ColorTween();

    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller!.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller!.forward();
        } else {
          _controller!.reverse().then<void>((nul) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext? context, Widget? child) {
    final Color borderSideColor = _borderColor!.evaluate(_easeOutAnimation!) ?? Colors.transparent;
    // final Color titleColor = _headerColor.evaluate(_easeInAnimation);

    return  Container(
      decoration: BoxDecoration(
          color: _backgroundColor!.evaluate(_easeOutAnimation!) ?? Colors.transparent,
          border:  Border(
            top:  BorderSide(color: borderSideColor),
            bottom:  BorderSide(color: borderSideColor),
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            // data: new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
            child: ListTile(
              //  onTap: toggle,
              //  leading: widget.leading,
              title:  _title,
              /* trailing: widget.trailing ?? new RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),*/
            ), data: const IconThemeData(),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation!.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor!.end = Colors.transparent;
    _headerColor!
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.accentColor;
    _iconColor!
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColor!.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller!.isDismissed;
    return AnimatedBuilder(
      animation: _controller!.view,
      builder: _buildChildren,
      child: closed ? null :  Column(children: widget.children!),
    );
  }
}