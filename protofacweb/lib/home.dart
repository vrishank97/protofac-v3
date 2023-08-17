import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './components/container.dart';
// ignore: depend_on_referenced_packages

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 132,
                width: screenWidth,
                color: const Color.fromRGBO(169, 204, 255, 1),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/ProtoFac.svg',
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            color: const Color.fromRGBO(28, 105, 255, 1),
                            child: const Text("Create your own workflows",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: SvgPicture.asset(
                          'images/ProtoFac.svg',
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Workflow for creating UI",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text("Creator : Roman Rajeev"),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Image.asset("images/Greenclock.png"),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    width: 4,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const ExpandableContainer(
                                name: 'Task 1',
                                time: 'Last Updated: 15th April 2022',
                                index: 1,
                                completedUnits: 20,
                                totalUnits: 40,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
