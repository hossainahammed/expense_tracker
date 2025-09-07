import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    title: const Text("ExpenseEase"),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004D40), Color(0xFF008B8B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    elevation: 4,
  );
}