import 'package:flutter/material.dart';

import '../../../../config/custom_colors.dart';


class CategoryTile extends StatelessWidget {
  final String categotiaName;
  final bool isSelect;
  final Function() onpress;

  const CategoryTile({
    Key? key,
    required this.categotiaName,
    required this.isSelect,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onpress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              color:
                  isSelect ? CustomColors.customSwatchColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(categotiaName,
              style: TextStyle(
                color: isSelect ? Colors.white : CustomColors.customContrastColor,
                fontSize: isSelect ? 16 : 14,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
