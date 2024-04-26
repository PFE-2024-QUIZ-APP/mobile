import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzapppfe/constants.dart';

class RoomPlayersList extends StatelessWidget {
  final List<dynamic> users;
  final bool sortByPoint;

  const RoomPlayersList({super.key, required this.users, this.sortByPoint = false});

  @override
  Widget build(BuildContext context) {
    List<dynamic> sortedUsers = List.from(users);
    print(sortedUsers);
    if (sortByPoint) {
      sortedUsers.sort((a, b) {
        int scoreA = a["score"] ?? 0; // Ensure score is treated as 0 if null
        int scoreB = b["score"] ?? 0; // Ensure score is treated as 0 if null
        return scoreB.compareTo(scoreA);
      });
    }

    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: sortedUsers.length,
        itemBuilder: (context, index) {
          final user = sortedUsers[index];
          return Container(
            color: blue,
            child: ListTile(
              titleTextStyle: TextGlobalStyle.listTileText,
              leading: Image.asset(
                      "lib/assets/images/avatar_${user["avatar"]}.png",
                      height: 40,
                      width: 40,
                    ),
              title: Text(user["name"]),
              subtitle: Text("${user["score"] ?? 0} PTS",
                  style: TextGlobalStyle.listTileText),
              trailing: SvgPicture.asset(host,
                  height: 30,
                  width: 30,
                  colorFilter: index == 0 && !sortByPoint
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
