
import 'package:flutter/material.dart';

class NewsHelper{

  Widget filterChip({VoidCallback? onTap,bool? isSelected,String? categoryName}){
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected ?? false
                ? LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.8),
                Colors.black.withValues(alpha: 0.5)
              ], // Light gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: isSelected == true
                ? Colors.white
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8),
          child: Center(
            child: Text(
              categoryName ?? '',
              style: TextStyle(
                color: isSelected == true
                    ? Colors.white
                    : Colors.black87,
                // Text color changes on selection
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );;
  }

}