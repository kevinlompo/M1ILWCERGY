import 'dart:async';
import 'package:flutter/material.dart';

class DelayAnimation extends StatefulWidget{
  Widget child;
  int duration;
  DelayAnimation({required this.child,required this.duration});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DelayAnimationState();
  }

}

class DelayAnimationState extends State<DelayAnimation> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<Offset> animationOffset;
  @override
  void initState(){
    super.initState();
    initialisationAnimation();
  }
  initialisationAnimation(){
    animationController = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 1000)
    );

    final curve = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animationOffset = Tween<Offset>(
        begin: const Offset(0.0,0.3),
        end: Offset.zero
    ).animate(curve);

    Timer(Duration(milliseconds: widget.duration), () {
      animationController.forward();
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeTransition(
        opacity: animationController,
      child: SlideTransition(
        position: animationOffset,
        child: widget.child,
      ),
    );
  }

}