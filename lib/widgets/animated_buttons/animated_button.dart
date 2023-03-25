import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final Function? onPressed;
  final bool loading;
  final double? height;
  final Color? backgroundColor;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final double borderRadius;

  const AnimatedButton({
    super.key,
    this.onPressed,
    required this.loading,
    this.height=45,
    this.backgroundColor=Colors.amber,
    required this.buttonText,
    this.buttonTextStyle,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          if(loading) return; //already loading, so...
          onPressed?.call();
        },
        child: Center(
          child: AnimatedContainer(
            width: !loading ? MediaQuery.of(context).size.width : 45,
            height: height,
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(loading ? 200: borderRadius,),
            ),
            //child: const FlutterLogo(size: 75),
            child: LayoutBuilder(builder: (_, constraints) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: constraints.maxWidth <= 70
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: Text(
                              buttonText,
                              style: buttonTextStyle,
                            ),
                          )),
              );
            }),
          ),
        ),
      ),
    );
  }
}
