import 'package:flutter/material.dart';

class StepperDemo extends StatefulWidget {
  StepperDemo(this.currentStep) : super();
  int currentStep = 0;
  @override
  StepperDemoState createState() => StepperDemoState(currentStep);
}

class StepperDemoState extends State<StepperDemo> {
  //
  List<String> stepTitles = [
    'Ordering',
    'Cooking',
    'Shipping',
    'Delivered',
    'Cancel'
  ];
  List<Step> steps = [];
  StepperDemoState(int currentStep) {
    stepTitles.forEach(
      (element) {
        steps.add(Step(
          title: Text("element"),
          content: Text(''),
          state: currentStep == stepTitles.indexOf(element)
              ? StepState.complete
              : StepState.disabled,
          isActive: true,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stepper(
        steps: steps,
        type: StepperType.horizontal,
      ),
    );
  }
}
