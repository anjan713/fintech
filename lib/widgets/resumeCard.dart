import 'package:flutter/material.dart';

extension CustomColor on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}

class CustomContainer extends StatefulWidget {
  final Widget child;
  final Color color;
  final double myradius;
  final Offset blurOffset;
  final bool shapes;
  final num paddingValue;
  CustomContainer({
    Key key,
    this.child,
    this.color,
    this.myradius = 10.0,
    this.shapes,
    this.paddingValue = 8.0,
  })  : this.blurOffset = Offset(myradius / 2, myradius / 2),
        super(key: key);

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  var _isPressed = false;
  void _myChange() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final color = this.widget.color ?? Theme.of(context).backgroundColor;
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          // _changeBool();
          _myChange();
          SnackBar snackbar = SnackBar(
            content: Text('Click the icon'),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snackbar);
        },
        onTapDown: (s) {
          _myChange();
        },
        // radius: 30,
        customBorder:
            widget.shapes ? ContinuousRectangleBorder() : CircleBorder(),
        borderRadius:
            widget.shapes ? BorderRadius.circular(widget.myradius) : null,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.all(widget.paddingValue),
          decoration: BoxDecoration(
              shape: widget.shapes ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  widget.shapes ? BorderRadius.circular(widget.myradius) : null,
              color: Colors.grey.shade200,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _isPressed ? color : color.mix(Colors.white, 0.1),
                    _isPressed ? color.mix(Colors.black, .05) : color,
                    _isPressed ? color.mix(Colors.black, .05) : color,
                    _isPressed ? color : color.mix(Colors.white, 0.5),
                  ],
                  stops: [
                    0.0,
                    0.3,
                    0.6,
                    1.0
                  ]),
              boxShadow: _isPressed
                  ? null
                  : [
                      BoxShadow(
                        blurRadius: widget.myradius,
                        offset: widget.blurOffset,
                        color: color.mix(Colors.white, 0.6),
                      ),
                      BoxShadow(
                        blurRadius: widget.myradius,
                        offset: widget.blurOffset,
                        color: color.mix(Colors.black, 0.3),
                      ),
                    ]),
          child: InkWell(child: widget.child),
        ),
      );
    });
  }
}

class InstagramButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final double myradius;
  final Offset blurOffset;
  final bool shapes;
  final num paddingValue;
  InstagramButton({
    Key key,
    this.child,
    this.color,
    this.myradius = 10.0,
    this.shapes,
    this.paddingValue = 8.0,
  })  : this.blurOffset = Offset(myradius / 2, myradius / 2),
        super(key: key);

  @override
  _InstagramButtonState createState() => _InstagramButtonState();
}

class _InstagramButtonState extends State<InstagramButton> {
  var _isPressed = false;
  void _myChange() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = this.widget.color ?? Theme.of(context).backgroundColor;
    return InkWell(
      onTap: () {
        // _changeBool();
        _myChange();
      },
      onTapDown: (s) {
        _myChange();
      },
      // radius: 30,
      customBorder:
          widget.shapes ? ContinuousRectangleBorder() : CircleBorder(),
      borderRadius:
          widget.shapes ? BorderRadius.circular(widget.myradius) : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.all(widget.paddingValue),
        decoration: BoxDecoration(
            shape: widget.shapes ? BoxShape.rectangle : BoxShape.circle,
            borderRadius:
                widget.shapes ? BorderRadius.circular(widget.myradius) : null,
            color: Colors.grey.shade200,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _isPressed ? color : color.mix(Colors.white, 0.1),
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  _isPressed ? color : color.mix(Colors.white, 0.5),
                ],
                stops: [
                  0.0,
                  0.3,
                  0.6,
                  1.0
                ]),
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      blurRadius: widget.myradius,
                      offset: widget.blurOffset,
                      color: color.mix(Colors.white, 0.6),
                    ),
                    BoxShadow(
                      blurRadius: widget.myradius,
                      offset: widget.blurOffset,
                      color: color.mix(Colors.black, 0.3),
                    ),
                  ]),
        child: InkWell(child: widget.child),
      ),
    );
  }
}
