import 'package:flutter/material.dart';
import 'package:expense_tracker_app/const/theme.dart';

class CustomTransection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgPath;

  const CustomTransection({super.key,required this.imgPath,required this.subtitle,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 90,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Color(0xff1F1F1F),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff95AEEE),
                  ),
                  child: Image(image: AssetImage(imgPath)),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      subtitle,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$31.1',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Color(0xffFF0000)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '12-02-2024',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
