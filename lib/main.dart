//Проект выполнен студентом группы ИТ-32, Мещеряковым Иваном
import 'dart:convert';
//import 'dart:html';
import 'package:websocket/websocket.dart' as web;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'dart:io';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

Soundpool pool = Soundpool(streamType: StreamType.notification);

//web.WebSocket connect;
web.WebSocket connect;
void main() async {
  /*
  var settings = new mysql.ConnectionSettings(
    host: 'alexmvhj.beget.tech',
    port: 3306,
    user: 'alexmvhj_tensor',
    password: 'Tensor123',
    db: 'alexmvhj_tensor',
  );
  conn = await mysql.MySqlConnection.connect(settings);
  */
  //async final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  /*
  wb = await WebSocket.connect('ws://armacoty.tk:1234');

  wb.addUtf8Text(utf8.encode("get_token:gavdiaser@ya.ru:dere123"));

  print("Ответ: " + await wb.stream.first);
  */
  // WebSocket.connect('ws://armacoty.tk:1234').then((WebSocket wbLoc) {
  //   wbLoc.add("get_token:gavdiaser@ya.ru:dere123");
  //   wbLoc.listen((List<int> event) {
  //     print("Ответ: " + event.toString());
  //   });
  //   //wbLoc.stream.transform(utf8.decoder).listen((event) {print("Ответ: " + event.toString());});
  //   //wbLoc.stream.listen((event) { print("Ответ: " + event.toString());})
  // });
  //connect = await web.WebSocket.connect('ws://armacoty.tk:1234');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teach-in',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: MaterialColor(0xFF602df9, {
          900: Color(0xFF0003df),
          800: Color(0xFF1519e5),
          700: Color(0xFF3a20ea),
          600: Color(0xFF5228f2),
          500: Color(0xFF602df9),
          400: Color(0xFF7f51fb),
          300: Color(0xFF9a73fc),
          200: Color(0xFFb99dfc),
          100: Color(0xFFd5c4fd),
          50: Color(0xFFefe7fe)
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Teach-In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Message {
  String firstname;
  String lastname;
  String message;
  DateTime time;
  bool isMine;

  Message(
      {@required this.firstname,
      @required this.lastname,
      @required this.message,
      @required this.time,
      @required this.isMine});
}

class User {
  int id;
  String firstname;
  String lastname;
  String email;
  bool isOnline;
  bool unread;

  User({
    @required this.id,
    @required this.firstname,
    @required this.lastname,
    this.email,
    this.unread,
    @required this.isOnline,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerEmail = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerFirstName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerMessage = TextEditingController();
  final _controllerSearch = TextEditingController();
  final _controllerPasswordRepeat = TextEditingController();

  final _controllerScrollToBottom = ScrollController();

  List<Message> messanges = [
    Message(
        firstname: 'Системное',
        lastname: 'сообщение',
        message: 'Отркройте чат с пользователем из списка слева',
        time: DateTime(2012, 1, 1, 1, 1, 1),
        isMine: false),
  ];

  User myUser = User(
    id: 2,
    firstname: 'Нет',
    lastname: 'Соединения',
    email: 'Нет соединения',
    isOnline: true,
    unread: false,
  );

  List<User> users = [
    User(
      id: 1,
      firstname: 'Нет',
      lastname: 'Соединения',
      email: 'Нет соединения',
      isOnline: false,
      unread: false,
    ),
  ];

  //String window = 'messanges';
  String window = 'register';
  String error = '';
  int curentChat = null;
  bool openSearch = false;

  void _go_to_login() {
    window = 'login';
    error = '';
    if (connect != null) {
      var query;
      query = <String, String>{
        'request': 'log_out',
        'my_id': myUser.id.toString(),
      };
      connect.add((json.encode(query)));
    }
    connect = null;
    curentChat = null;
    messanges = [
    Message(
        firstname: 'Системное',
        lastname: 'сообщение',
        message: 'Отркройте чат с пользователем из списка слева',
        time: DateTime(2012, 1, 1, 1, 1, 1),
        isMine: false),
  ];

  myUser = User(
    id: 2,
    firstname: 'Нет',
    lastname: 'Соединения',
    email: 'Нет соединения',
    isOnline: true,
    unread: false,
  );

  users = [
    User(
      id: 1,
      firstname: 'Нет',
      lastname: 'Соединения',
      email: 'Нет соединения',
      isOnline: false,
      unread: false,
    ),
  ];
    setState(() {});

  }

  void _go_to_register() {
    window = 'register';
    error = '';
    connect = null;
    curentChat = null;
    messanges = [
    Message(
        firstname: 'Системное',
        lastname: 'сообщение',
        message: 'Отркройте чат с пользователем из списка слева',
        time: DateTime(2012, 1, 1, 1, 1, 1),
        isMine: false),
  ];

  myUser = User(
    id: 2,
    firstname: 'Нет',
    lastname: 'Соединения',
    email: 'Нет соединения',
    isOnline: true,
    unread: false,
  );

  users = [
    User(
      id: 1,
      firstname: 'Нет',
      lastname: 'Соединения',
      email: 'Нет соединения',
      isOnline: false,
      unread: false,
    ),
  ];
    setState(() {});
  }

  void _go_to_messanges() {
    window = 'messanges';
    error = '';
    if (connect != null) {
      var query;
      query = <String, String>{
        'request': 'all_chats',
        'my_id': myUser.id.toString(),
      };
      connect.add((json.encode(query)));
    }
    setState(() {});
  }

  void _go_to_contacts() {
    var query;
    query = <String, String>{
      'request': 'all_chats',
      'my_id': myUser.id.toString(),
    };
    connect.add((json.encode(query)));
    //openSearch = false;
    //setState(() {});
  }

  void _log_in() async {
    error = '';
    if (((_controllerFirstName.text == '') && (window == 'register')) ||
        ((_controllerLastName.text == '') && (window == 'register')) ||
        ((_controllerPasswordRepeat.text == '') && (window == 'register')) ||
        (_controllerEmail.text == '') ||
        (_controllerPassword.text == '')) {
      error = 'Заполните все поля';
      print('Заполните все поля');
      setState(() {});
      return;
    }

    if ((_controllerPassword.text != _controllerPasswordRepeat.text) &&
        (window == 'register')) {
      error = 'Пароли не совпадают';
      print('Пароли не совпадают');
      setState(() {});
      return;
    }

    if (connect == null) {
      try {
        connect = await web.WebSocket.connect('ws://armacoty.tk:1234');
      } catch (e) {
        error = 'Нет подключения к серверу';
        print('Нет подключения к серверу');
        setState(() {});
        return;
      }
      connect.stream.listen((event) async {
        Map input = json.decode(event.toString());
        print("Ответ: " + input.toString());
        if (input['answer'].toString() == 'successful autorize') {
          myUser = new User(
              id: input['id'],
              firstname: input['name'],
              lastname: input['last_name'],
              email: _controllerEmail.text,
              isOnline: true);
          print(myUser.id);
          print(myUser.firstname);
          print(myUser.lastname);
          print(myUser.email);
          print(myUser.isOnline);

          _go_to_messanges();
        } else if (input['answer'].toString() == 'autorize error') {
          connect = null;
          error = 'Ошибка авторизации';
          print('Ошибка авторизации');
          setState(() {});
        } else if (input['answer'].toString() == 'all_chats successful') {
          users.clear();
          //print(input['users'].length);
          for (int index = 0; index < input['users'].length; index++) {
            users.add(
              User(
                  id: input['users'][index]['id'],
                  firstname: input['users'][index]['name'],
                  lastname: input['users'][index]['last_name'],
                  unread: false,
                  isOnline: input['users'][index]['status'] == 'online'),
            );
            openSearch = false;
          }
          setState(() {});
        } else if (input['answer'].toString() == 'all_find_client') {
          users.clear();
          for (int index = 0; index < input['client'].length; index++) {
            users.add(
              User(
                  id: input['client'][index]['id'],
                  firstname: input['client'][index]['name'],
                  lastname: input['client'][index]['last_name'],
                  unread: false,
                  isOnline: input['client'][index]['status'] == 'online'),
            );
          }
          openSearch = true;
          setState(() {});
        } else if (input['answer'].toString() == 'chats_with') {
          messanges.clear();
          //print(input['users'].length);
          for (int index = 0; index < input['message'].length; index++) {
            messanges.insert(
                0,
                Message(
                    firstname: input['message'][index]['from'] != ''
                        ? input['message'][index]['from']
                        : myUser.firstname,
                    lastname: input['message'][index]['last_name'] != ''
                        ? input['message'][index]['last_name']
                        : myUser.lastname,
                    message: input['message'][index]['message'],
                    time: DateTime.parse(input['message'][index]['date']),
                    isMine:
                        input['message'][index]['from'] == '' ? true : false));
          }
          setState(() {});
        } else if (input['answer'].toString() == 'send_message') {
          var query;
          _controllerMessage.text = '';
          query = <String, String>{
            'request': 'open_chat',
            'my_id': myUser.id.toString(),
            'id': curentChat.toString(),
          };
          connect.add((json.encode(query)));
        } else if (input['answer'].toString() == 'new_message') {
          print('Сообщение');
          if (input['id'] == curentChat) {
            messanges.insert(
                0,
                Message(
                    firstname: input['from'],
                    lastname: input['last_name'],
                    message: input['message'],
                    time: DateTime.parse(input['date']),
                    isMine: false));

            setState(() {
              _controllerScrollToBottom.animateTo(0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500));
            });
          } else {
            Soundpool pool = Soundpool(streamType: StreamType.notification);
            int soundId = await rootBundle.load("assets/sound.mp3").then(
              (ByteData soundData) {
                return pool.load(soundData);
              },
            );
            int streamId = await pool.play(soundId, repeat: 0, rate: 1);
            users.forEach((user) {
              if (user.id == input['id']) { user.unread = true; user.isOnline = true; };
            });
          }
        }
      });
    }
    var query;
    if (window == 'register') {
      query = <String, String>{
        'request': 'new_token',
        'name': _controllerFirstName.text,
        'last_name': _controllerLastName.text,
        'email': _controllerEmail.text,
        'password': _controllerPassword.text,
      };
      connect.add((json.encode(query)));
      print('жду');
      //sleep(Duration(milliseconds: 500));
    }
    query = <String, String>{
      'request': 'get_token',
      'email': _controllerEmail.text,
      'password': _controllerPassword.text,
    };
    connect.add((json.encode(query)));
    //sleep(Duration(milliseconds: 1000));
    //connect.add((json.encode(query)));

    //TODO Listen
    //print("Ответ: " + json.decode(await connect.stream.first));
    //("get_token:gavdiaser@ya.ru:dere123"));
  }

  void _start_chat(int id) {
    print(id);
    curentChat = id;
    var query;
    query = <String, String>{
      'request': 'open_chat',
      'my_id': myUser.id.toString(),
      'id': id.toString(),
    };
    connect.add((json.encode(query)));
    Navigator.pop(context);
    _controllerMessage.text = '';
    users.forEach((user) {
      if (user.id == id) user.unread = false;
    });
  }

  void _send_message() {
    if (curentChat != null) {
      var query;
      query = <String, String>{
        'request': 'add_message',
        'my_id': myUser.id.toString(),
        'message': _controllerMessage.text,
        'id': curentChat.toString()
      };
      connect.add((json.encode(query)));
    }
  }

  void _search() {
    connect.add((json.encode({
      'request': 'find_users',
      'my_id': myUser.id.toString(),
      "search_keys": _controllerSearch.text.split(" "),
    })));
    //setState(() {});
  }
  /*
    mysql.Results result = await conn.query('select name, message from test');

    messages = [];
    result.forEach((mysql.Row row) {
      String name1 = "!", message1 = "ашибка";
      name1 = row[0];
      message1 = row[1];
      messages.add(Message(name: name1, message: message1));
    });
    messages = messages.reversed.toList();

    _controllerMessage.text = '';

    setState(() {
      _controllerScrollToBottom.animateTo(0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    });
    */
  //

  //Код для сетевой части
  /*
    wb = await web.WebSocket.connect('ws://armacoty.tk:1234');

    wb.addUtf8Text(utf8.encode("get_token:gavdiaser@ya.ru:dere123"));

    print("Ответ: " + await wb.stream.first);
    */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(),
        ),
        leading: window == 'messanges'
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          /*
          height: (window != 'messanges')
              ? MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight
                  : null
              : (MediaQuery.of(context).orientation == Orientation.portrait) &&
                      (window == 'messanges')
                  ? MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight
                  : MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
*/
          height: (window == 'messanges')
              ? MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight
              : null,

          //MediaQuery.of(context).size.height -
          //MediaQuery.of(context).padding.top,
          /*
          height:
              (MediaQuery.of(context).orientation == Orientation.portrait) &&
                      (window == 'messanges')
                  ? MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top
                  : MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
          */
          child: window == 'messanges'
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Color(0xFFefe7fe),
                        child: Scrollbar(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ListView.builder(
                              controller: _controllerScrollToBottom,
                              reverse: true,
                              shrinkWrap: false,
                              itemCount: messanges.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  //padding: messages[index].isMine
                                  //    ? EdgeInsets.only(left: 50)
                                  //    : EdgeInsets.only(right: 50),
                                  child: Column(
                                    children: [
                                      if (index == messanges.length - 1)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            DateFormat("dd.MM.yyyy")
                                                .format(messanges[index].time)
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12),
                                          ),
                                        ),
                                      if ((index != messanges.length - 1) &&
                                          (DateFormat("dd.MM.yyyy")
                                                  .format(messanges[index].time)
                                                  .toString() !=
                                              DateFormat("dd.MM.yyyy")
                                                  .format(
                                                      messanges[index + 1].time)
                                                  .toString()))
                                        Text(
                                          DateFormat("dd.MM.yyyy")
                                              .format(messanges[index].time)
                                              .toString(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12),
                                        ),
                                      Padding(
                                        padding: messanges[index].isMine
                                            ? EdgeInsets.only(left: 70)
                                            : EdgeInsets.only(right: 70),
                                        child: Card(
                                          child: Container(
                                            margin: new EdgeInsets.all(7),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      messanges[index]
                                                              .firstname +
                                                          ' ' +
                                                          messanges[index]
                                                              .lastname,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        DateFormat("hh:mm a")
                                                            .format(
                                                                messanges[index]
                                                                    .time)
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  messanges[index].message,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(height: 1),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //fillColor: Colors.grey[200],
                              //filled: true,
                              hintText: 'Напишите сообщение',
                            ),
                            controller: _controllerMessage,
                          ),
                        ),
                        ButtonTheme(
                          height: 58,
                          //minWidth: 140,
                          child: RaisedButton(
                            onPressed: () {
                              _send_message();
                            },
                            //shape: RoundedRectangleBorder(
                            //borderRadius: BorderRadius.circular(100),
                            //side: BorderSide(color: Colors.red),
                            //),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 35,
                            ),
                            //child: Text(
                            //  'Register',
                            //  style:
                            //      TextStyle(color: Colors.white, fontSize: 25),
                            //),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 15, left: 50, right: 50, bottom: 10),
                      child: Container(
                        height: 125,
                        child: Image.asset("assets/teach-in_v2.3.png"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 50, bottom: 15, right: 15),
                            child: ButtonTheme(
                              height: 50,
                              minWidth: 140,
                              child: RaisedButton(
                                onPressed: () {
                                  _go_to_login();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                color: window == 'register'
                                    ? Color(0xFF602df9)
                                    : Colors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 15,
                              right: 50,
                            ),
                            child: ButtonTheme(
                              height: 50,
                              minWidth: 140,
                              child: RaisedButton(
                                onPressed: () {
                                  _go_to_register();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                color: window == 'register'
                                    ? Colors.lightBlue
                                    : Color(0xFF602df9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 50, right: 50, bottom: 3, top: 5),
                      child: Text(
                        "E-mail:",
                        style: TextStyle(color: Color(0xFF602df9)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ваш электронный ящик',
                        ),
                        controller: _controllerEmail,
                      ),
                    ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, bottom: 3, top: 5),
                        child: Text(
                          "Фамилия:",
                          style: TextStyle(color: Color(0xFF602df9)),
                        ),
                      ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: TextField(
                          style: TextStyle(height: 1),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Ваша Фамилия'),
                          controller: _controllerLastName,
                        ),
                      ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, bottom: 3, top: 5),
                        child: Text(
                          "Имя:",
                          style: TextStyle(color: Color(0xFF602df9)),
                        ),
                      ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          style: TextStyle(height: 1),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ваше Имя',
                          ),
                          controller: _controllerFirstName,
                        ),
                      ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 50, right: 50, bottom: 3, top: 5),
                      child: Text(
                        "Пароль:",
                        style: TextStyle(color: Color(0xFF602df9)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        style: TextStyle(height: 1),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ваш пароль',
                        ),
                        controller: _controllerPassword,
                      ),
                    ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, bottom: 3, top: 5),
                        child: Text(
                          "Повторите пароль:",
                          style: TextStyle(color: Color(0xFF602df9)),
                        ),
                      ),
                    if (window == 'register')
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          style: TextStyle(height: 1),
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ваш пароль',
                          ),
                          controller: _controllerPasswordRepeat,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 50, right: 50, bottom: 5),
                            child: ButtonTheme(
                              height: 50,
                              //minWidth: 500,
                              child: RaisedButton(
                                onPressed: () {
                                  _log_in();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: Text(
                                  'Let\'s go',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                color: Color(0xFF602df9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),

                    // Expanded(
                    //   child: Scrollbar(
                    //     child: ListView.builder(
                    //       controller: _controllerScrollToBottom,
                    //       reverse: true,
                    //       padding: EdgeInsets.only(left: 50, right: 50),
                    //       itemCount: messages.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return ListTile(
                    //           title: Text(messages[index].name),
                    //           subtitle: Text(messages[index].message),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
      drawer: window == 'messanges'
          ? Container(
              width: MediaQuery.of(context).size.width,
              child: Drawer(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(height: 1),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //fillColor: Colors.grey[200],
                              //filled: true,
                              hintText: 'Найти друга',
                            ),
                            controller: _controllerSearch,
                          ),
                        ),
                        ButtonTheme(
                          height: 58,
                          //minWidth: 140,
                          child: RaisedButton(
                            onPressed: () {
                              _search();
                            },
                            //shape: RoundedRectangleBorder(
                            //borderRadius: BorderRadius.circular(100),
                            //side: BorderSide(color: Colors.red),
                            //),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 35,
                            ),
                            //child: Text(
                            //  'Register',
                            //  style:
                            //      TextStyle(color: Colors.white, fontSize: 25),
                            //),
                          ),
                        )
                      ]),
                      if (openSearch)
                        Row(
                          children: [
                            Expanded(
                              child: ButtonTheme(
                                height: 50,
                                //minWidth: 500,
                                child: RaisedButton(
                                  onPressed: () {
                                    _go_to_contacts();
                                  },
                                  child: Text(
                                    'Назад к списку контактов',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  color: Color(0xFF602df9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Expanded(
                        child: Container(
                          color: Color(0xFFefe7fe),
                          child: Scrollbar(
                            child: ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        _start_chat(users[index].id);
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15, right: 7.5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    users[index].firstname +
                                                        ' ' +
                                                        users[index].lastname,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (users[index].unread)
                                                Icon(
                                                  Icons.message,
                                                  size: 30,
                                                  color: Colors.orange,
                                                ),
                                              /*
                                              Text(users[index].unread
                                                  ? 'Новое сообщение'
                                                  : ''),
                                                  */
                                              Icon(
                                                Icons.circle,
                                                size: 30,
                                                color: users[index].isOnline
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      endDrawer: window == 'messanges'
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Drawer(
                  child: Container(
                    color: Color(0xFFefe7fe),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 10, left: 95),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    //margin: EdgeInsets.all(100.0),
                                    decoration: BoxDecoration(
                                        //color: Colors.red,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/no-avatar.jpg"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                ButtonTheme(
                                  height: 85,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 115),
                                    child: RaisedButton(
                                      onPressed: () {
                                        _go_to_login();
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(100.0)),
                                      child: Icon(Icons.logout,
                                          color: Colors.white, size: 30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            myUser.firstname + ' ' + myUser.lastname,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            myUser.email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );

    /*
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _sendMessage();
        },
        tooltip: 'Send message',
        child: Icon(Icons.message),
      ),
      */
  }
}
