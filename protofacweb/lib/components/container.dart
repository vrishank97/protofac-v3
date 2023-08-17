import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {

  final String name;
  final String time;
  final int index;
  final int completedUnits;
  final int totalUnits;

  const ExpandableContainer({super.key, 
    required this.name,
    required this.time,
    required this.index,
    required this.completedUnits,
    required this.totalUnits,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  double _value = 10.0;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: screenWidth*0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.789889335632324),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task 1',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Last Updated: 15th April 2022',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 14,),
                            Text(
                                "Manufacture 40 Tshirts",
                                style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Container(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.green,
                                inactiveTrackColor: const Color.fromRGBO(239, 239, 239, 1),
                                trackHeight: 24.0,
                                thumbColor: Colors.black,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 13.0,pressedElevation: 8.0,),
                                overlayColor: Colors.purple.withAlpha(32),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Colors.black,
                                valueIndicatorTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max: 100,
                                value: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                            ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            width: screenWidth * 0.36,
                            height: screenWidth* 0.2,
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expected Start date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    '27/04/2023',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: screenWidth * 0.36,
                            height: screenWidth* 0.2,
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expected Start date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    '27/04/2023',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            width: screenWidth * 0.36,
                            height: screenWidth* 0.2,
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expected Start date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    '27/04/2023',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: screenWidth * 0.36,
                            height: screenWidth* 0.2,
                            color: const Color.fromRGBO(239, 239, 239, 1),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expected Start date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    '27/04/2023',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
