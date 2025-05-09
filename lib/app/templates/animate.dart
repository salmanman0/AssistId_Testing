import 'package:flutter/material.dart';

class LeftIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const LeftIn({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  _LeftInState createState() => _LeftInState();
}

class _LeftInState extends State<LeftIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Mulai dari luar layar kanan
      end: Offset.zero, // Akhirnya berada di posisi normal
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Bisa diganti sesuai kebutuhan
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RightIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const RightIn({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  _RightInState createState() => _RightInState();
}

class _RightInState extends State<RightIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero, 
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TopIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const TopIn({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  _TopInState createState() => _TopInState();
}

class _TopInState extends State<TopIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BottomIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const BottomIn({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  _BottomInState createState() => _BottomInState();
}

class _BottomInState extends State<BottomIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
