### 引用包

1、在pubspec.yaml添加引用

```ruby

  flutter_luk:
    git: https://github.com/HOKI-GROUP/flutter_luk.git
```

### 使用

**只需配置GameView，即可使用,GameView可以配置在正常的页面(互动游戏)、也可配置在Dialog中(概率游戏)**

```java
          GameView(
            url: "游戏的URL,由业务后端向SDK方获取",
            gid: "游戏的ID,由业务后端向SDK方获取",
            rid: "这里填写业务方的房间ID",
            canOpenGame: true,
            //是否可以打开游戏
            language: "en",
            //游戏语言
            width: MediaQuery.of(context).size.width.toInt(),
            height: MediaQuery.of(context).size.height.toInt(),
            cid: '这里填写LUK SDK给的Appid',
            uid: "业务用户Uid",
            token: "业务token,",
            padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.of(context).padding.top + 32,
                16,
                MediaQuery.of(context).padding.bottom + 16),
            //游戏安全区
            preJoinGame: (int uid, int seat) async {
              //TODO 加入前回调
              return true;
            },
            openChargePage: () async {
              //TODO 跳转 到充值页面
            },
          ),
```

### GameView主要参数和Api说明

| 参数或回调方法          | 说明                  |
| :--------------- | :------------------ |
| url              | 游戏的URL,由业务后端向SDK方获取 |
| gid              | 游戏的ID,由业务后端向SDK方获取  |
| rid              | 业务方的房间ID            |
| uid              | 业务的用户ID             |
| cid              | AppId               |
| token            | 业务方请求接口的token       |
| language         | 语言，例： en            |
| padding          | 视图边距，互动游戏才有         |
| gameLoadFail()   | 游戏加载错误回调(互动游戏)      |
| preJoinGame()    | 加入游戏前回调(互动游戏)       |
| joinGame()       | 加入游戏回调(互动游戏)        |
| cancelPrepare()  | 取消游戏前回调(互动游戏)       |
| gameTerminated() | 游戏终止(互动游戏)          |
| gameOver()       | 游戏结束(互动游戏)          |
| openChargePage() | 打开充值界面              |
| closeGamePage()  | 关闭游戏                |

