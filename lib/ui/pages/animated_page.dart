import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    Color colors = Colors.grey;

    Future.delayed(const Duration(seconds: 2)).then(
      (value) => colors = Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(!isChange ? 'Animation' : 'Custom Paint'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isChange = !isChange;
              });
            },
            icon: const Icon(
              Icons.change_circle,
            ),
          ),
        ],
      ),
      body: !isChange
          ? Center(
              child: TweenAnimationBuilder<double>(
                builder: (BuildContext context, value, Widget? child) {
                  return Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 200.h,
                          width: 200.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 8.w,
                            backgroundColor: Colors.grey,
                            color: Colors.greenAccent,
                            value: value,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.done,
                          color: colors,
                          size: 80,
                        ),
                      ),
                    ],
                  );
                },
                tween: Tween<double>(begin: 0.0, end: 3),
                duration: const Duration(milliseconds: 6000),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 500.h,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.green],
                        ),
                      ),
                      child: CustomPaint(
                        size: const Size(500, 400),
                        painter: MyPainter(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    Path paths = Path();

    paths.lineTo(0, size.height * 0.5);

    paths.cubicTo(
      size.width * 0.3,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.7,
      size.width,
      size.height * 0.5,
    );

    paths.lineTo(size.width, 0);
    canvas.drawPath(paths, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
