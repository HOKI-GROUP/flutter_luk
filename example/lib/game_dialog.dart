import 'package:flutter/material.dart';
import 'package:flutter_luk/flutter_luk.dart';

class GameDialog {
  static void showGameDialog(BuildContext context,
      {required int gameId,
      required String gameName,
      required String gameUrl}) {
    showDialog(
        context: context,
        builder: (context) {
          return GameView(
            key: ValueKey(gameId),
            url: gameUrl,
            gid: gameId.toString(),
            rid: "room_id",
            //这里填写业务方的房间ID
            canOpenGame: true,
            //是否可以打开游戏
            language: "en",
            //游戏语言
            width: MediaQuery.of(context).size.width.toInt(),
            height: (MediaQuery.of(context).size.height * 0.8).toInt(),
            cid: '',
            //Luk SDK的appId
            uid: "",
            //业务用户Uid
            token: "",
            //业务token,
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).padding.bottom),
            preJoinGame: (int uid, int seat) async {
              //TODO 加入前回调
              return true;
            },
            openChargePage: () async {
              //TODO 跳转 到充值页面
            },
          );
        });
  }
}
