import 'package:flutter/material.dart';

class CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  CardData(
    this.text, {
      required this.descriptionText,
      this.icon = Icons.abc_outlined,
      this.imageUrl,
    }
  );
}
