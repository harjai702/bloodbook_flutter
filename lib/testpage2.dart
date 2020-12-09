import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class Testpage2 extends StatefulWidget {
  @override
  _Testpage2State createState() => _Testpage2State();
}

class _Testpage2State extends State<Testpage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
                Opacity(
                  opacity: 0.7,
                  child: ClipPath(
                    clipper: WaveClipperOne(),
                    child: Opacity(opacity: 0.8,
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent[100],
                        ),
                        child: Stack(
                          children: <Widget>[
                          Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child:  Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          ),),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/light-2.png')
                                    )
                                ),
                              )),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child:  Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/clock.png')
                                )
                            ),
                          )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
