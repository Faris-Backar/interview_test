import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback ontap;
  final Widget? tailWidget;
  const PrimaryButton({
    Key? key,
    required this.label,
    required this.ontap,
    this.tailWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      tileColor: Colors.grey[300],
      titleTextStyle: const TextStyle(color: Colors.black54, fontSize: 16),
      onTap: ontap,
    );
  }
}
