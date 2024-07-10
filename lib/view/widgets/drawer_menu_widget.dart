// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:note_app/core/theme/app_styles.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.onTap,
      this.iconColor,
      this.textColor,
      this.isActive = false,
      this.itemCount})
      : super(key: key);
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final void Function()? onTap;
  final bool isActive;
  final String? itemCount;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: isActive ? Colors.grey[300] : null,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                // size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: AppStyles.heading3.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const Spacer(),
              Text(
                itemCount == null ? "" : itemCount!,
                style: AppStyles.bodyRegularS
                    .copyWith(color: const Color(0xFF6F6E6E)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
