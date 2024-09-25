import 'package:flutter/material.dart';

class PersonalInfoComponent extends StatelessWidget {
  const PersonalInfoComponent(
      {required this.text1,
      required this.text2,
      super.key,
      required this.icon});

  final String text1;
  final String text2;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text1,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          text2,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16),
        ),
        // SizedBox(
        //   width: MySize.size16,
        // ),
        // Icon(icon,
        //     size: MySize.size15, color: AppColor.blackColor.withOpacity(0.38))
      ],
    );
  }
}
