import 'package:flutter/material.dart';

class CategoryItemChip extends StatefulWidget {
  const CategoryItemChip({super.key});

  @override
  State<CategoryItemChip> createState() => _CategoryItemChipState();
}

class _CategoryItemChipState extends State<CategoryItemChip> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            color: Colors.red,
            shadows: const [
              BoxShadow(
                color: Colors.black,
                blurStyle: BlurStyle.normal,
                blurRadius: 25,
                spreadRadius: -15,
                offset: Offset(0.0, 15),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        const Text(
          'همه',
          style: TextStyle(
            fontFamily: 'SM',
          ),
        ),
      ],
    );
  }
}
