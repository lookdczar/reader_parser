import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jscore/flutter_jscore.dart';
import 'package:yuedu_parser/h_parser/dsoup/soup_object_cache.dart';
import 'package:yuedu_parser/h_parser/h_parser.dart';
import 'package:yuedu_parser/h_parser/jscore/JSRuntime.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // runJS();
    // testDio();
    testJsParser();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void runJS() {
    var jsRuntime = JSRuntime.init(SoupObjectCache());
    jsRuntime.injectArgs({'id':'123'});
    JSValue jsValue = jsRuntime.evaluate('''
    var doc = org.jsoup.Jsoup.parse('<div><p>content</p><p>p2p</p></div>');
    doc.select('p');
    ''');
    print(jsValue.string);
    if(jsValue.isObject){
      String serialized = jsValue.createJSONString(null).string;
      print(serialized);
    }
    jsRuntime.destroy();

  }

  void testJsParser(){
    var json_str = r'''
  {"items":[{"novelintroshort":"\u56db\u7237\uff0c\u6211\u4e0d\u6405\u57fa\u2026\u2026","novelstep":2,"authorid":837527,"tags":"","novelname":"\u7ea2\u697c\u4e4b\u51e1\u4eba\u8d3e\u73af","ebookurl":"","novelborndate":1352176440,"novelid":1659716,"novelsize":593028,"authorname":"duoduo","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=1659716&coverid=13&ver=520d8f2a9493b48a7a6e29ad2d7158c5","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127173611_56a88f8b90af4_321.jpg","novelClass":"\u884d\u751f-\u7eaf\u7231-\u67b6\u7a7a\u5386\u53f2-\u4e1c\u65b9\u884d\u751f","novelSizeformat":"59.3\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u4e00\u4e2a\u666e\u901a\u4eba\u5728\u54e8\u5175\u5411\u5bfc\u4e16\u754c\u7684\u6545\u4e8b","novelstep":1,"authorid":856289,"tags":"\u79d1\u5e7b \u60c5\u6709\u72ec\u949f \u52b1\u5fd7\u4eba\u751f \u73b0\u4ee3\u67b6\u7a7a","novelname":"\u51e1\u4eba\u6b4c","ebookurl":"https:\/\/s2.ax1x.com\/2020\/01\/05\/lBCgqe.jpg","novelborndate":1403156551,"novelid":2147873,"novelsize":1107128,"authorname":"\u5927\u6c5f\u660e\u6708","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=2147873&coverid=24&ver=97d35a3b199fdd6cb5b8cb3bfcea2f12","local":0,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127175841_56a894d10b4b7_602.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u5e7b\u60f3\u672a\u6765-\u7231\u60c5","novelSizeformat":"110.71\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u771f\u7684\u597d\u96be","novelstep":2,"authorid":2230738,"tags":"\u60c5\u6709\u72ec\u949f \u751c\u6587 \u723d\u6587 \u53f2\u8bd7\u5947\u5e7b","novelname":"\u548c\u51e1\u4eba\u6210\u4eb2\u597d\u96be","ebookurl":"http:\/\/i2-static.jjwxc.net\/tmp\/backend\/authorspace\/s1\/23\/22308\/2230738\/20200709155935.jpg","novelborndate":1526998942,"novelid":3586365,"novelsize":161682,"authorname":"\u4eca\u69d8","cover":"http:\/\/i2-static.jjwxc.net\/tmp\/backend\/authorspace\/s1\/23\/22308\/2230738\/20200709155935_200_280.jpg","local":0,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170118142820_587f0b049c6ac_720.jpg","novelClass":"\u539f\u521b-\u8a00\u60c5-\u67b6\u7a7a\u5386\u53f2-\u5947\u5e7b","novelSizeformat":"16.17\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u7a7f\u6210\u5bab\u4e5d","novelstep":2,"authorid":313204,"tags":"\u6b66\u4fa0 \u7a7f\u8d8a\u65f6\u7a7a","novelname":"[*******\uff01","ebookurl":"","novelborndate":1328299627,"novelid":1439396,"novelsize":213945,"authorname":"\u58a8*","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=1439396&coverid=13&ver=543d09f29cf23bbb98cb34d27346c147","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127173611_56a88f8b90af4_321.jpg","novelClass":"\u884d\u751f-\u7eaf\u7231-\u67b6\u7a7a\u5386\u53f2-\u4e1c\u65b9\u884d\u751f","novelSizeformat":"21.39\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u5feb\u7a7f","novelstep":2,"authorid":10437,"tags":"\u5feb\u7a7f \u5929\u4f5c\u4e4b\u5408 \u79cd\u7530\u6587","novelname":"\u78be\u538b\u51e1\u4eba\u7684\u4e00\u767e\u79cd\u65b9\u5f0f","ebookurl":"http:\/\/ww4.sinaimg.cn\/mw1024\/006cT5Rmjw1ezxw73mucyj305k07sq3e.jpg","novelborndate":1455934210,"novelid":2651946,"novelsize":275175,"authorname":"\u9690\u7a7a\u4eba","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=2651946&coverid=12&ver=5b489bf5a4e903f130aa81531c8ea9a0","local":0,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127173534_56a88f66b60a9_247.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u67b6\u7a7a\u5386\u53f2-\u7231\u60c5","novelSizeformat":"27.52\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u4f60\u7684\u5b69\u5b50\u50cf\u6211\uff08\u5feb\u7a7f\uff09","novelstep":2,"authorid":1956831,"tags":"\u751f\u5b50 \u5feb\u7a7f \u73b0\u4ee3\u67b6\u7a7a \u60ac\u7591\u63a8\u7406","novelname":"\u5feb\u7a7f\u4e4b\u5e73\u51e1\u4eba\u751f","ebookurl":"","novelborndate":1503987821,"novelid":3332892,"novelsize":379543,"authorname":"\u592a\u7a7a\u5f71\u5b50","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=3332892&coverid=23&ver=a9b48d781e238f59bc4970963fdbf286","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127175800_56a894a84a160_511.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u8fd1\u4ee3\u73b0\u4ee3-\u7231\u60c5","novelSizeformat":"37.95\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u5c14\u7b49\u51e1\u4eba\uff0c\u9000\u6563\uff0c\u9000\u6563\uff01","novelstep":2,"authorid":814696,"tags":"\u5bab\u5ef7\u4faf\u7235 \u4ed9\u4fa0\u4fee\u771f \u7ea2\u697c\u68a6","novelname":"\u7ea2\u697c\u4e4b\u5c14\u7b49\u51e1\u4eba","ebookurl":"","novelborndate":1432544400,"novelid":2453937,"novelsize":240447,"authorname":"\u82cd\u767d\u5c11\u5973","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=2453937&coverid=21&ver=c0664a7488c14e1040e7c690fc639e1b","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127175555_56a8942b13276_345.jpg","novelClass":"\u884d\u751f-\u7eaf\u7231-\u67b6\u7a7a\u5386\u53f2-\u53e4\u5178\u884d\u751f","novelSizeformat":"24.04\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u5976\u7238\u4eec\u5e26\u5a03\u5954\u5c0f\u5eb7","novelstep":1,"authorid":1118110,"tags":"","novelname":"\u5e73\u51e1\u4eba\u95f4","ebookurl":"","novelborndate":1557992558,"novelid":4066588,"novelsize":346462,"authorname":"\u9646\u7fbd\u61be","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=4066588&coverid=14&ver=eaea096888d898e3fb7bb7516fa20e60","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127174956_56a892c4e76e2_383.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u8fd1\u4ee3\u73b0\u4ee3-\u7231\u60c5","novelSizeformat":"34.65\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u5c0f\u53a8\u5e08\u7a7f\u8d8a\u5230\u73b0\u4ee3\u7684\u5e73\u51e1\u6545\u4e8b","novelstep":2,"authorid":306503,"tags":"\u7075\u9b42\u8f6c\u6362 \u7a7f\u8d8a\u65f6\u7a7a \u90fd\u5e02\u60c5\u7f18 \u7ade\u6280","novelname":"\u7a7f*******\u751f","ebookurl":"","novelborndate":1230549305,"novelid":414589,"novelsize":226963,"authorname":"\u5c18*","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=414589&coverid=21&ver=ab8a17764eec25174a624ee2f4a4765a","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127175555_56a8942b13276_345.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u8fd1\u4ee3\u73b0\u4ee3-\u7231\u60c5","novelSizeformat":"22.7\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u52aa\u529b\u751f\u6d3b\uff0c\u575a\u6301\u5973\u7231","novelstep":2,"authorid":255790,"tags":"\u5e03\u8863\u751f\u6d3b \u82b1\u5b63\u96e8\u5b63","novelname":"\u7981*******\uff09","ebookurl":"","novelborndate":1226483945,"novelid":397593,"novelsize":205695,"authorname":"\u518d*******\u6c34","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=397593&coverid=16&ver=c985da68e4bda86fd7eef5fa33ca7cff","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127174718_56a8922652de3_916.jpg","novelClass":"\u539f\u521b-\u767e\u5408-\u8fd1\u4ee3\u73b0\u4ee3-\u7231\u60c5","novelSizeformat":"20.57\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u81ea\u8bb8\u7eff\u53f6\u7684\u5973\u4e3b\u5728\u5f02\u754c\u7684\u5e73\u6de1\u65e5\u5b50","novelstep":2,"authorid":581437,"tags":"\u5929\u4f5c\u4e4b\u5408 \u7a7f\u8d8a\u65f6\u7a7a \u79cd\u7530\u6587","novelname":"\u5c0f\u7eff\u53f6\u7684\u5e73\u51e1\u4eba\u751f","ebookurl":"","novelborndate":1361197799,"novelid":1735147,"novelsize":375624,"authorname":"\u5bd2\u666f\u67d4","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=1735147&coverid=6&ver=b0cdba0f511b49b95147f64ba4ebbb7d","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20151120165416_564edfb903625_546.jpg","novelClass":"\u539f\u521b-\u8a00\u60c5-\u67b6\u7a7a\u5386\u53f2-\u7231\u60c5","novelSizeformat":"37.56\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u4e3b\u89d2\u548c\u4e3b\u89d2\u7ecf\u5386\u7684\u53e4\u602a\u6545\u4e8b","novelstep":2,"authorid":769572,"tags":"\u7a7f\u8d8a\u65f6\u7a7a \u4ed9\u4fa0\u4fee\u771f","novelname":"\u51e1\u4eba\u970d\u5e08\u5085\uff08\u4fee\u771f+\u602a\u8c08\uff09","ebookurl":"","novelborndate":1542294183,"novelid":3529573,"novelsize":169293,"authorname":"\u674e\u7166\u4e4b","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=3529573&coverid=82&ver=09fe15d3aa774d08160e6a24d0e819cc","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170120143235_5881af0360eb3_688.jpg","novelClass":"\u539f\u521b-\u8a00\u60c5-\u67b6\u7a7a\u5386\u53f2-\u7231\u60c5","novelSizeformat":"16.93\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u6211\u662f\u5bb6\u65cf\u6709\u53f2\u4ee5\u6765\u7b2c\u4e00\u4e2a\u51e1\u4eba","novelstep":2,"authorid":389604,"tags":"\u8650\u604b\u60c5\u6df1 \u8fb9\u7f18\u604b\u6b4c \u7a7f\u8d8a\u65f6\u7a7a","novelname":"\u51e1\u4eba","ebookurl":"","novelborndate":1254838259,"novelid":577601,"novelsize":194615,"authorname":"\u77e2\u5fd7\u4e0d\u6e1d","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=577601&coverid=111&ver=bb513b75a8935787c720437e23c5e259","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170527094919_5928db1ff0b0d_886.jpg","novelClass":"\u884d\u751f-\u7eaf\u7231-\u5e7b\u60f3\u672a\u6765-\u897f\u65b9\u884d\u751f","novelSizeformat":"19.46\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u7528\u6734\u7d20\u7684\u6587\u5b57\u63cf\u5199\u4eba\u95f4\u6700\u771f\u7684\u60c5\u611f","novelstep":2,"authorid":452403,"tags":"","novelname":"\u7a7f\u8d8a\u5317\u5b8b\u4e4b\u51e1\u4eba\u60c5","ebookurl":"","novelborndate":1272337442,"novelid":714358,"novelsize":282830,"authorname":"\u4e50\u9e3f","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=714358&coverid=5&ver=aebb65193a5840902a44459bf1575a5f","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20151120130520_564eaa1086f30_648.jpg","novelClass":"\u539f\u521b-\u8a00\u60c5-\u53e4\u8272\u53e4\u9999-\u7231\u60c5","novelSizeformat":"28.28\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u695a\u8f69\u5e93\u6d1b\u6d1b\u4e8c\u5408\u4e00\u7684\u6545\u4e8b","novelstep":1,"authorid":1819136,"tags":"","novelname":"\u730e*******\uff09","ebookurl":"http:\/\/wx4.sinaimg.cn\/mw1024\/9f4fc234gy1fjdc5iu7kdj20mg0vq7az.jpg","novelborndate":1465516800,"novelid":2797339,"novelsize":204872,"authorname":"\u591c*******\u5149","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=2797339&coverid=26&ver=49edbfac1b0ac98eedfdb4319471282b","local":0,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127180026_56a8953a68561_303.jpg","novelClass":"\u884d\u751f-\u7eaf\u7231-\u8fd1\u4ee3\u73b0\u4ee3-\u4e1c\u65b9\u884d\u751f","novelSizeformat":"20.49\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u62ef\u6551\u4e16\u754c\u8fd8\u662f\u6211\u6765\u5427","novelstep":1,"authorid":1587044,"tags":"\u5f3a\u5f3a \u5f02\u4e16\u5927\u9646 \u7a7f\u8d8a\u65f6\u7a7a \u65e0\u9650\u6d41","novelname":"\u542c\u8bf4\u51e1\u4eba\u662f\u877c\u8681","ebookurl":"","novelborndate":1474674867,"novelid":2936380,"novelsize":0,"authorname":"\u51e4\u9ece\u4e5d\u60dc","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=2936380&coverid=13&ver=10ce8e0a2d1c22e71f8ca09c6f688024","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127173611_56a88f8b90af4_321.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u67b6\u7a7a\u5386\u53f2-\u7231\u60c5","novelSizeformat":"0\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u8d31\u5927\u795e\u548c\u4ed6\u7684\u57fa\u53cb\u4eec","novelstep":1,"authorid":261247,"tags":"\u6b22\u559c\u51a4\u5bb6 \u5929\u4e4b\u9a84\u5b50","novelname":"\uff08*******\u9053","ebookurl":"","novelborndate":1320926581,"novelid":1368181,"novelsize":212628,"authorname":"\u53f8*******\u543e","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=1368181&coverid=20&ver=c583c7cdbcfa88b4647f45473701690f","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20160127175411_56a893c39ce78_301.jpg","novelClass":"\u539f\u521b-\u7eaf\u7231-\u8fd1\u4ee3\u73b0\u4ee3-\u6e38\u620f","novelSizeformat":"21.26\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u82e6\u903c\u59b9\u5b50\u5728\u9ad8\u667a\u5546\u4eba\u7fa4\u7684\u78be\u538b\u751f\u6d3b","novelstep":1,"authorid":1901541,"tags":"\u82f1\u7f8e\u884d\u751f \u60c5\u6709\u72ec\u949f \u8d85\u7ea7\u82f1\u96c4","novelname":"\u7efc\u82f1\u7f8e+\u5168\u5bb6\u5c31\u6211\u662f\u51e1\u4eba","ebookurl":"","novelborndate":1491275160,"novelid":3150310,"novelsize":150121,"authorname":"\u5440\u5440\u606d\u5f25","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=3150310&coverid=90&ver=3b362e84683006bcec741418c4e5bdee","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170120143528_5882afb0c3383_159.jpg","novelClass":"\u884d\u751f-\u8a00\u60c5-\u67b6\u7a7a\u5386\u53f2-\u897f\u65b9\u884d\u751f","novelSizeformat":"15.01\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u5fb7\u4e91\u793e\u6210\u5458\u7684\u604b\u7231\u77ed\u6587","novelstep":1,"authorid":2208995,"tags":"\u60c5\u6709\u72ec\u949f \u5a31\u4e50\u5708 \u5973\u626e\u7537\u88c5","novelname":"[\u5fb7\u4e91\u793e]\u4f60\u6211\u7686\u51e1\u4eba","ebookurl":"https:\/\/wx1.sinaimg.cn\/mw1024\/006NcoValy1ggw8605a24j310s1j7b29.jpg","novelborndate":1554524400,"novelid":4107237,"novelsize":294662,"authorname":"\u5b5f\u8046\u542c\u5416","cover":"https:\/\/wx1.sinaimg.cn\/mw1024\/006NcoValy1ggw8605a24j310s1j7b29.jpg","local":0,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170118142538_587f0a6269e56_123.jpg","novelClass":"\u884d\u751f-\u8a00\u60c5-\u8fd1\u4ee3\u73b0\u4ee3-\u4e1c\u65b9\u884d\u751f","novelSizeformat":"29.47\u4e07","novelintro":"","favoriteStatus":"0"},{"novelintroshort":"\u7a7f\u8d8a\u51e1\u4eba\uff0c\u4ee5\u51e1\u4eba\u4e4b\u8eab\uff0c\u5bfb\u6c42\u4ed9\u8def","novelstep":1,"authorid":581491,"tags":"\u7a7f\u8d8a\u65f6\u7a7a \u4ed9\u4fa0\u4fee\u771f \u5973\u5f3a","novelname":"\uff08\u51e1\u4eba\u4fee\u4ed9\u4f20\uff09\u4ed9\u8def","ebookurl":"","novelborndate":1315133252,"novelid":1298229,"novelsize":173661,"authorname":"\u51e1\u4e16","cover":"http:\/\/i9-static.jjwxc.net\/novelimage.php?novelid=1298229&coverid=91&ver=e24a2e745083ca5ca0855061c5475ce3","local":1,"localImg":"http:\/\/i9-static.jjwxc.net\/tmp\/frontcover\/basecover\/20170120143558_5881afce89553_567.jpg","novelClass":"\u884d\u751f-\u8a00\u60c5-\u53e4\u8272\u53e4\u9999-\u4e1c\u65b9\u884d\u751f","novelSizeformat":"17.37\u4e07","novelintro":"","favoriteStatus":"0"}],"count":661,"words":"\u51e1\u4eba","activity":[]}
  ''';
    var test_html = r'<a id="123">qq_3</a>';
    var rule1 = r"id##2<js>result=result-1;baseUrl.replace(/index=\\d+/,'')+'index='+result</js>";
    var rule2 = r"text";
    var rule3 = r"<js>org.jsoup.Jsoup.parse(result).select('a')</js>";
    var rule4 = r"$.items";

    var test_json = r'[{"volume_id":8869,"id":8869,"volume_name":"\u7b2c\u4e00\u5377","volume_order":10,"chapters":[{"chapter_id":92147,"chapter_name":"\u5e8f\u7ae0","chapter_order":100},{"chapter_id":92148,"chapter_name":"\u7b2c\u4e00\u7ae0 \u6211\u4e0e\u59b9\u59b9\u6210\u4e3a\u8f7b\u5c0f\u8bf4\u5bb6\u7684\u7406\u7531","chapter_order":110},{"chapter_id":92149,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u6211\u59b9\u59b9\u7684\u76ee\u6807\u5230\u5e95\u6709\u591a\u4e48\u8fdc\u5927\u554a","chapter_order":120},{"chapter_id":92150,"chapter_name":"\u7b2c\u4e09\u7ae0 \u5c31\u7b97\u662f\u8fd9\u6837\uff0c\u6210\u4eba\u6e38\u620f\u5bf9\u59b9\u59b9\u6765\u8bf4\u8fd8\u662f\u592a\u65e9\u4e86","chapter_order":130},{"chapter_id":92151,"chapter_name":"\u7b2c\u56db\u7ae0 \u5c3d\u7ba1\u5982\u6b64\uff0c\u6211\u4ecd\u65e7\u662f\u4f60\u7684\u54e5\u54e5\u554a","chapter_order":140},{"chapter_id":92152,"chapter_name":"\u5c3e\u58f0","chapter_order":150},{"chapter_id":92153,"chapter_name":"\u540e\u8bb0","chapter_order":160},{"chapter_id":80298,"chapter_name":"\u63d2\u753b","chapter_order":190}]},{"volume_id":9020,"id":9020,"volume_name":"\u7b2c\u4e8c\u5377","volume_order":20,"chapters":[{"chapter_id":92154,"chapter_name":"\u5e8f\u7ae0","chapter_order":100},{"chapter_id":92155,"chapter_name":"\u7b2c\u4e00\u7ae0 \u6211\u53ea\u4e0d\u8fc7\u662f\u60f3\u8981\u8ffd\u4e0a\u59b9\u59b9\u800c\u5df2","chapter_order":110},{"chapter_id":92156,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u4f1a\u53d8\u6210\u5f97\u8ddf\u59b9\u59b9\u7ea6\u4f1a\uff0c\u57fa\u672c\u4e0a\u90fd\u662f\u6211\u7684\u9519","chapter_order":120},{"chapter_id":92157,"chapter_name":"\u7b2c\u4e09\u7ae0 \u8981\u505a\u5230\u4ec0\u4e48\u5730\u6b65\uff0c\u6211\u624d\u80fd\u6210\u4e3a\u6c38\u8fdc\u91ce\u8a93\u5462","chapter_order":130},{"chapter_id":92158,"chapter_name":"\u7b2c\u56db\u7ae0 \u73b0\u5728\u6211\u6562\u8bf4\u51fa\u53e3\u3002\u6211\u6700\u559c\u6b22\u7684\u5c31\u662f\u59b9\u59b9\u4e86\uff01","chapter_order":140},{"chapter_id":92159,"chapter_name":"\u5c3e\u58f0","chapter_order":150},{"chapter_id":92160,"chapter_name":"\u540e\u8bb0","chapter_order":160},{"chapter_id":80309,"chapter_name":"\u63d2\u753b","chapter_order":190}]},{"volume_id":9066,"id":9066,"volume_name":"\u77ed\u7bc7","volume_order":30,"chapters":[{"chapter_id":80844,"chapter_name":"2017\u5bcc\u58eb\u89c1\u5927\u611f\u8c22\u796d\u573a\u8d29\u77ed\u7bc7","chapter_order":10},{"chapter_id":83769,"chapter_name":"\u548c\u59b9\u59b9\u73a9Galgame\u4e5f\u662f\u53d6\u6750","chapter_order":20},{"chapter_id":83770,"chapter_name":"\u65e5\u5386\u77ed\u7bc7","chapter_order":30},{"chapter_id":93950,"chapter_name":"2018\u5723\u8bde\u77ed\u7bc7","chapter_order":40},{"chapter_id":93951,"chapter_name":"2019\u65e5\u5386\u77ed\u7bc7","chapter_order":50}]},{"volume_id":9142,"id":9142,"volume_name":"\u7b2c\u4e09\u5377","volume_order":40,"chapters":[{"chapter_id":92161,"chapter_name":"\u5e8f\u7ae0","chapter_order":100},{"chapter_id":92162,"chapter_name":"\u7b2c\u4e00\u7ae0 \u4e0d\u5f53\u8f7b\u5c0f\u8bf4\u4f5c\u5bb6\uff0c\u662f\u4ec0\u4e48\u610f\u601d\u554a\uff1f","chapter_order":110},{"chapter_id":92163,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u7edd\u5bf9\u4e0d\u80fd\u8f93\u7684\u540c\u4eba\u5fd7\u5bf9\u51b3","chapter_order":120},{"chapter_id":92164,"chapter_name":"\u7b2c\u4e09\u7ae0 \u6b22\u8fce\u5149\u4e34\u767d\u6a31\u5973\u5b66\u9662\u6821\u5e86\uff01","chapter_order":130},{"chapter_id":92165,"chapter_name":"\u7b2c\u56db\u7ae0 \u6211\u7231\u51c9\u82b1\uff08\u7684\u4f5c\u54c1\uff09\u3002","chapter_order":140},{"chapter_id":92166,"chapter_name":"\u5c3e\u58f0","chapter_order":150},{"chapter_id":92167,"chapter_name":"\u540e\u8bb0","chapter_order":160},{"chapter_id":81698,"chapter_name":"\u63d2\u753b","chapter_order":190}]},{"volume_id":9539,"id":9539,"volume_name":"\u7b2c\u56db\u5377","volume_order":50,"chapters":[{"chapter_id":88201,"chapter_name":"\u63d2\u753b","chapter_order":90},{"chapter_id":92169,"chapter_name":"\u5e8f\u7ae0","chapter_order":100},{"chapter_id":92170,"chapter_name":"\u7b2c\u4e00\u7ae0 \u6361\u5230\u79bb\u5bb6\u51fa\u8d70\u7684\u58f0\u4f18\uff1f","chapter_order":110},{"chapter_id":92171,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u6709\u5173\u51fa\u73b0\u65b0\u59b9\u59b9\u7684\u4e8b\u60c5","chapter_order":120},{"chapter_id":92172,"chapter_name":"\u7b2c\u4e09\u7ae0 \u8fc7\u591c\u8db4\u4e0e\u6e38\u4e50\u56ed\u7ea6\u4f1a","chapter_order":130},{"chapter_id":92173,"chapter_name":"\u7b2c\u56db\u7ae0 \u6211\u840c\u59b9\u59b9\u5c31\u591f\u4e86","chapter_order":140},{"chapter_id":92174,"chapter_name":"\u5c3e\u58f0","chapter_order":150},{"chapter_id":92175,"chapter_name":"\u540e\u8bb0","chapter_order":160}]},{"volume_id":9705,"id":9705,"volume_name":"\u7b2c\u4e94\u5377","volume_order":60,"chapters":[{"chapter_id":92176,"chapter_name":"\u8f6c\u8f7d\u4fe1\u606f","chapter_order":100},{"chapter_id":92177,"chapter_name":"\u5e8f\u7ae0","chapter_order":110},{"chapter_id":92178,"chapter_name":"\u7b2c\u4e00\u7ae0 \u53ef\u7231\u5973\u4e3b\u89d2\u7684\u5236\u9020\u6cd5","chapter_order":120},{"chapter_id":92179,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u767d\u96ea\u4e0e\u84b8\u6c14\u7684\u96c6\u8bad","chapter_order":130},{"chapter_id":92180,"chapter_name":"\u7b2c\u4e09\u7ae0 \u521b\u4f5c\u8005\u4eec\u7684\u5723\u8bde\u8282","chapter_order":140},{"chapter_id":92181,"chapter_name":"\u7b2c\u56db\u7ae0 \u6210\u4eba\u7ea6\u4f1a\u4e0e\u54e5\u54e5\u7684\u544a\u767d","chapter_order":150},{"chapter_id":92182,"chapter_name":"\u5c3e\u58f0","chapter_order":160},{"chapter_id":92183,"chapter_name":"\u540e\u8bb0","chapter_order":170},{"chapter_id":90025,"chapter_name":"\u63d2\u753b","chapter_order":190}]},{"volume_id":9851,"id":9851,"volume_name":"\u7b2c\u516d\u5377","volume_order":70,"chapters":[{"chapter_id":92233,"chapter_name":"\u8f6c\u8f7d\u4fe1\u606f","chapter_order":10},{"chapter_id":92234,"chapter_name":"\u5e8f\u7ae0","chapter_order":20},{"chapter_id":92235,"chapter_name":"\u7b2c\u4e00\u7ae0 \u65b0\u7684\u72b6\u51b5\uff0c\u65b0\u7684\u4f5c\u54c1","chapter_order":30},{"chapter_id":92236,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u867d\u8bf4\u7a81\u7136\uff0c\u4f46\u8bf7\u5bb9\u6211\u79bb\u5f00\u5bb6\u91cc","chapter_order":40},{"chapter_id":92237,"chapter_name":"\u7b2c\u4e09\u7ae0 \u60c5\u4eba\u8282\u7684\u653b\u9632","chapter_order":50},{"chapter_id":92238,"chapter_name":"\u7b2c\u56db\u7ae0 \u4f60\u975e\u5f97\u662f\u59b9\u59b9\u4e0d\u53ef","chapter_order":60},{"chapter_id":92239,"chapter_name":"\u7ec8\u7ae0","chapter_order":70},{"chapter_id":92240,"chapter_name":"\u540e\u8bb0","chapter_order":80},{"chapter_id":92241,"chapter_name":"\u63d2\u753b","chapter_order":90}]},{"volume_id":10180,"id":10180,"volume_name":"\u7b2c\u4e03\u5377","volume_order":80,"chapters":[{"chapter_id":97224,"chapter_name":"\u8f6c\u8f7d\u4fe1\u606f","chapter_order":10},{"chapter_id":97225,"chapter_name":"\u5e8f\u7ae0","chapter_order":20},{"chapter_id":97226,"chapter_name":"\u7b2c\u4e00\u7ae0 \u6709\u59b9\u59b9\u5728\u7684\u98ce\u666f","chapter_order":30},{"chapter_id":97227,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u537f\u537f\u6211\u6211\u675f\u7f1aPLAY\uff01\uff1f","chapter_order":40},{"chapter_id":97228,"chapter_name":"\u7b2c\u4e09\u7ae0 \u8fde\u7ed3\u53cb\u60c5\u7684\u4f20\u6559\u6d3b\u52a8","chapter_order":50},{"chapter_id":97229,"chapter_name":"\u7b2c\u56db\u7ae0 \u542c\u542c\u6211\u7684\u4efb\u6027","chapter_order":60},{"chapter_id":97230,"chapter_name":"\u7ec8\u7ae0","chapter_order":70},{"chapter_id":97231,"chapter_name":"\u540e\u8bb0","chapter_order":80},{"chapter_id":97232,"chapter_name":"\u63d2\u753b","chapter_order":90}]},{"volume_id":10895,"id":10895,"volume_name":"\u7b2c7.5\u5377","volume_order":90,"chapters":[{"chapter_id":107069,"chapter_name":"\u8f6c\u8f7d\u4fe1\u606f","chapter_order":10},{"chapter_id":107070,"chapter_name":"\u5e8f\u7ae0","chapter_order":20},{"chapter_id":107071,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u751c\u871c\u871c\u6307\u5bfc","chapter_order":30},{"chapter_id":107072,"chapter_name":"\u8ddf\u6c38\u8fdc\u91ce\u8a93\u6f14\u7ec3\u5e78\u8fd0\u8272\u72fc","chapter_order":40},{"chapter_id":107073,"chapter_name":"\u8ddf\u6c38\u8fdc\u91ce\u8a93\u5230\u79cb\u53f6\u539f\u5b9e\u4e60","chapter_order":50},{"chapter_id":107074,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u5316\u8eab\u59b9\u59b9\u8bb2\u5ea7","chapter_order":60},{"chapter_id":107075,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u6700\u7ec8\u544a\u767d\u6307\u5357","chapter_order":70},{"chapter_id":107076,"chapter_name":"\u5c3e\u58f0 \u6c38\u8fdc\u91ce\u8a93\u4e0e\u5bf9\u624b\u518d\u73b0","chapter_order":80},{"chapter_id":107077,"chapter_name":"\u540e\u8bb0","chapter_order":90},{"chapter_id":107086,"chapter_name":"\u63d2\u753b","chapter_order":100}]},{"volume_id":10896,"id":10896,"volume_name":"\u7b2c\u516b\u5377","volume_order":100,"chapters":[{"chapter_id":107078,"chapter_name":"\u5e8f\u7ae0","chapter_order":10},{"chapter_id":107079,"chapter_name":"\u5e8f\u7ae0","chapter_order":20},{"chapter_id":107080,"chapter_name":"\u7b2c\u4e00\u7ae0 \u51fa\u9053\u5f53\u4f5c\u5bb6\u4e4b\u8def","chapter_order":30},{"chapter_id":107081,"chapter_name":"\u7b2c\u4e8c\u7ae0 \u94bb\u7814\u7231\u60c5\u559c\u5267","chapter_order":40},{"chapter_id":107082,"chapter_name":"\u7b2c\u4e09\u7ae0 \u4e0d\u51c6\u9003\u907f\u53d6\u6750\uff01","chapter_order":50},{"chapter_id":107083,"chapter_name":"\u7b2c\u56db\u7ae0 \u539f\u70b9\u7684\u59b9\u59b9","chapter_order":60},{"chapter_id":107084,"chapter_name":"\u5c3e\u58f0","chapter_order":70},{"chapter_id":107085,"chapter_name":"\u540e\u8bb0","chapter_order":80},{"chapter_id":107087,"chapter_name":"\u63d2\u753b","chapter_order":90}]},{"volume_id":11021,"id":11021,"volume_name":"\u7b2c8.5\u5377","volume_order":110,"chapters":[{"chapter_id":108963,"chapter_name":"\u8f6c\u8f7d\u4fe1\u606f","chapter_order":10},{"chapter_id":108964,"chapter_name":"\u548c\u59b9\u59b9\u73a9Galgame\u4e5f\u662f\u53d6\u6750","chapter_order":20},{"chapter_id":108965,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u7f51\u6e38\u4f53\u9a8c\u8bb0","chapter_order":30},{"chapter_id":108966,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u6843\u8272\u7ec3\u4e60","chapter_order":40},{"chapter_id":108967,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u70ed\u60c5\u91c7\u8bbf","chapter_order":50},{"chapter_id":108968,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u7ea0\u845b\u767d\u8272\u60c5\u4eba\u8282","chapter_order":60},{"chapter_id":108969,"chapter_name":"\u6c38\u8fdc\u91ce\u8a93\u7684\u56de\u5fc6\u65e5\u8bb0","chapter_order":70},{"chapter_id":108970,"chapter_name":"\u540e\u8bb0","chapter_order":80},{"chapter_id":108983,"chapter_name":"\u63d2\u753b","chapter_order":90}]}]';
    var rule_toc = '<js>var url=\"https://v3api.dmzj.com/novel/download/999999_\";var list=[];JSON.parse(result).forEach(li=>{var ch_list=li.chapters.map(x=>({vol:li.volume_id,chap:x.chapter_id,name:li.volume_name+\"\"+x.chapter_name}));Array.prototype.push.apply(list,ch_list);});list.map(ch=>({name:ch.name,link:url+ch.vol+\"_\"+ch.chap+\".txt\"}))</js>';
    var cache = SoupObjectCache();
    var jsRuntime = JSRuntime.init(cache);
    var hparser = HParser('test_text');
    hparser.objectCache = SoupObjectCache();
    hparser.injectArgs = {'baseUrl':'http://baidu.com?index=123'};
    var result = hparser.parseRuleString('@js:result.replace(/&[a-z]{4,};/ig,"")');
    var t = DateTime.now();
    print('${t}');
    // for (var value in result) {
    //   // print(value.text);
    //   // print(value.outerHtml);
    //   var eParser = HParser.forNode(value);
    //   eParser.jsRuntime = jsRuntime;
    //   var result = eParser.parseRuleString('name');
    //   print(result);
    // }

    print(result);
    print('${DateTime.now().difference(t).inMilliseconds}');
    jsRuntime.destroy();
  }


}
