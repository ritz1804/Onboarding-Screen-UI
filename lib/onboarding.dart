import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skateboard_onboarding/models/models.dart';
import 'package:skateboard_onboarding/provider/indexNotifier.dart';
import 'package:skateboard_onboarding/provider/offsetNotifier.dart';
import 'dart:math' as math;

class MyOnboarding extends StatefulWidget {
  @override
  _MyOnboardingState createState() => _MyOnboardingState();
}

class _MyOnboardingState extends State<MyOnboarding> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              MyAppBar(),
              Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      Provider.of<IndexNotifier>(context, listen: false).index =
                          index;
                    },
                    children: <Widget>[
                      MySamurai(),
                      Villain(),
                      Chase(),
                    ],
                  )),
              MyBottomBar(),
            ],
          ),
        ),
      ),
      create: (BuildContext context) => OffsetNotifier(_pageController),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'ONE WAY',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
            ),
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 12),
          child: MyPageIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'VIEW BOARD',
            style: TextStyle(letterSpacing: 4, fontFamily: 'Poppins'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 12),
          child: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class MyPageIndicator extends StatelessWidget {
  _indicatorCircle(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<IndexNotifier>(context).index;
    return Row(
      children: List.generate(
        skateboards.length,
            (i) => _indicatorCircle(index == i),
      ),
    );
  }
}

class SkateboardBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class MySamurai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 440,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: math.max(0, 1 - value.page),
                    child: Opacity(
                      opacity: math.max(0, 1 - value.page),
                      child: child,
                    ),
                  );
                },
                child: SkateboardBackground(),
              ),
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: math.pi * value.page,
                    child: child,
                  );
                },
                child: Image.asset('images/samurai.png'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Consumer<OffsetNotifier>(
          builder: (context, value, child) {
            return Opacity(
              opacity: math.max(0, 1 - 2 * value.page),
              child: child,
            );
          },
          child: Column(
            children: <Widget>[
              Text(
                skateboards[0].title,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 28),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  skateboards[0].desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Villain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 440,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  double process;
                  if (value.page <= 1) {
                    process = math.max(0, 4 * value.page - 3);
                  } else {
                    process = math.max(0, 1 - 4 * (value.page - 1));
                  }
                  return Transform.scale(
                    scale: process,
                    child: child,
                  );
                },
                child: SkateboardBackground(),
              ),
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  double process;
                  if (value.page <= 1) {
                    process = math.max(0, 4 * value.page - 3);
                  } else {
                    process = math.max(0, 1 - 4 * (value.page - 1));
                  }
                  return Transform.translate(
                    offset: Offset(0, -50 * (1 - process)),
                    child: child,
                  );
                },
                child: Image.asset('images/reject.png'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Consumer<OffsetNotifier>(
          builder: (context, value, child) {
            double process;
            if (value.page <= 1) {
              process = math.max(0, 4 * value.page - 3);
            } else {
              process = math.max(0, 1 - 4 * (value.page - 1));
            }
            return Transform.translate(
              offset: Offset(0, 50 * (1 - process)),
              child: Opacity(
                child: child,
                opacity: process,
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Text(
                skateboards[1].title,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 28),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  skateboards[1].desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Chase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 440,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  // value.page goes from 1.0 - 2.0, seat at 2.0 when stop at page to
                  double process = math.max(0, 3 * value.page - 5);
                  return Transform.scale(
                    scale: process,
                    child: child,
                  );
                },
                child: SkateboardBackground(),
              ),
              Consumer<OffsetNotifier>(
                builder: (context, value, child) {
                  double process = math.max(0, 3 * value.page - 5);
                  return Transform(
                    alignment: FractionalOffset.center,
                    // we want rotate the content upside down
                    // why not use process,because when value.page comes 1.7, the process down to 0
                    // but value.page = range(1.0 - 2.0) that what we want.
                    transform:
                    Matrix4.translationValues(0, 100 * (1 - process), 0)
                      ..rotateZ(-math.pi * value.page),
                    child: child,
                  );
                },
                child: Image.asset('images/chase.png'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Consumer<OffsetNotifier>(
          builder: (context, value, child) {
            double process = math.max(0, 3 * value.page - 5);
            return Transform.translate(
              offset: Offset(0, 50 * (1 - process)),
              child: Opacity(
                child: child,
                opacity: process,
              ),
            );
          },
          child: Text(
            skateboards[2].title,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
          ),
        ),
        SizedBox(height: 20),
        Consumer<OffsetNotifier>(
          builder: (context, value, child) {
            double process = math.max(0, 3 * value.page - 5);
            return Opacity(
              opacity: process,
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              skateboards[2].desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}