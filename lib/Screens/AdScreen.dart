import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:testing/Utils/globalVariables.dart';

class AdPage extends StatelessWidget {
  const AdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider("https://picsum.photos/200"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.top,
                list: [
                  BezierCurveSection(
                    start: Offset(screenWidth, 30),
                    top: Offset(screenWidth / 4 * 3, 0),
                    end: Offset(screenWidth / 2, 30),
                  ),
                  BezierCurveSection(
                    start: Offset(screenWidth / 2, 30),
                    top: Offset(screenWidth / 4, 60),
                    end: Offset(0, 0),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                color: mainCTAColor,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2x1 en el día de la madre en Alma Café',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
