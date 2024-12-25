import 'package:accounts_book/const/const_color.dart';
import 'package:flutter/material.dart';

import 'add_amount_screen.dart';

class DetailsOFAllAmountsScreen extends StatelessWidget {
  const DetailsOFAllAmountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.wihteColor,
      appBar: AppBar(
        backgroundColor: ConstColors.appBar,
        iconTheme: IconThemeData(
          color: ConstColors.iconappBar,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              children: [],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: ConstColors.appBar,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: ConstColors.iconappBar,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Column(
                      children: [
                        Text(
                          'عليه:=0',
                          style: TextStyle(
                            color: ConstColors.textColor,
                          ),
                        ),
                        Text(
                          'محلي',
                          style: TextStyle(
                            color: ConstColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AddAmountScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        color: ConstColors.iconappBar,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
