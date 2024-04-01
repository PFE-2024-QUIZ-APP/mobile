import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzapppfe/constants.dart';

class RoomPlayersList extends StatelessWidget {
  final List<dynamic> users;

  const RoomPlayersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            color: blue,
            child: ListTile(
              titleTextStyle: TextGlobalStyle.listTileText,
              leading: user["avatar"] != "avatar"
                  ? SvgPicture.asset(
                      user["avatar"],
                      height: 40,
                      width: 40,
                    )
                  : SvgPicture.asset(
                      profile,
                      height: 40,
                      width: 40,
                    ),
              title: Text(user["name"]),
              subtitle: Text("${user["score"] ?? 0} PTS",
                  style: TextGlobalStyle.listTileText),
              trailing: SvgPicture.asset(host,
                  height: 30,
                  width: 30,
                  colorFilter: index == 0
                      ? null
                      : const ColorFilter.mode(
                          Colors.transparent, BlendMode.srcIn)),
              tileColor: Colors.white,
              selected: false,
              selectedColor: Colors.red,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1.0,
            thickness: 2.0,
            color: lightBlue,
          );
        },
      ),
    );
  }
}
