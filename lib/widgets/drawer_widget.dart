import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/drawar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final DrawersController _drawersController = DrawersController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.builder(
            itemCount: _drawersController.drawerMode.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Get.back();
                  Get.toNamed(_drawersController.drawerScreen[index]);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) =>
                  //             _drawersController.drawerScreen[index]));
                },
                child: Container(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.01 / 3.5),
                  child: Column(
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            _drawersController.drawerMode[index].iconData,
                            color: ConstColors.blackColor.withOpacity(0.5),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            _drawersController.drawerMode[index].text,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: ConstColors.dividerColor,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
