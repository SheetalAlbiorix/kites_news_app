import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kites_news_app/src/core/style/app_colors.dart';

class NewsHelper{

  Widget filterChip({VoidCallback? onTap,bool? isSelected,String? categoryName}){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ??false
                ? AppColors().chipSelectedBGColor
                : AppColors().chipBGColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            categoryName ?? "",
            style: TextStyle(
              color: isSelected ?? false
                  ?AppColors().chipSelectedTextColor
                  : AppColors().chipTextColor,
              fontSize: 14,
              fontWeight:FontWeight.bold,
            ),
          ),
        ),
      ),
    );;
  }

}