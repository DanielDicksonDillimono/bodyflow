import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/barbell.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                child: Column(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
