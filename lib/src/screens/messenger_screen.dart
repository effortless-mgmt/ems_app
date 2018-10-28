import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/services.dart';

const String _myName = "User";
const String _recipName = "Recipient";

class MessengerScreen extends StatefulWidget {
  @override
  State createState() => new MessengerScreenState();
}

class MessengerScreenState extends State<MessengerScreen>
    with TickerProviderStateMixin {
  List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  bool _test = true;

  MessengerScreenState() {
    debugPrint("Test enabled: $_test");

    if (_test) {
      loadTestData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      // key: key,
      appBar: new AppBar(
        title: new Text(_recipName),
        elevation:
            Theme.of(context).platform == TargetPlatform.android ? 4.0 : 0.0,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.call),
        //     onPressed: () => key.currentState.showSnackBar(new SnackBar(
        //           content: new Text("Call recipient"),
        //         )),
        //   )
        // ],
      ),
      body: new Container(
        // child: GestureDetector(
        // onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildEditText(),
            )
          ],
        ),
        // ),
        decoration: Theme.of(context).platform == TargetPlatform.android
            ? null
            : BoxDecoration(
                border:
                    new Border(top: new BorderSide(color: Colors.grey[200]))),
      ),
    );
  }

  Widget _buildEditText() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                  controller: _textController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _submit,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send a message")),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.android
                    ? new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => _submit(_textController.text)
                            : null,
                      )
                    : new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: _isComposing
                            ? () => _submit(_textController.text)
                            : null,
                      )),
          ],
        ),
      ),
    );
  }

  void _submit(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      sender: _myName,
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 250),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  void loadTestData() {
    AnimationController animationController = new AnimationController(
      duration: new Duration(milliseconds: 250),
      vsync: this,
    );

    ChatMessage msg1 = ChatMessage(
        sender: "User",
        text: "Hello!",
        animationController: animationController);

    ChatMessage msg2 = ChatMessage(
        sender: "Recipient",
        text: "Hi!",
        animationController: animationController);

    ChatMessage msg3 = ChatMessage(
        sender: "User",
        text:
            "Can you tell me how to get in? I have been standing outside for the past 45 minutes! Also, my pants are on fire, so that sucks. Bring the fire extinguisher.",
        animationController: animationController);

    ChatMessage msg4 = ChatMessage(
        sender: "Recipient",
        text: "Woah. I will be right there!",
        animationController: animationController);

    ChatMessage msg5 = ChatMessage(
        sender: "User",
        text: "Thank you. I'm still burning, please hurry!",
        animationController: animationController);

    ChatMessage msg6 = ChatMessage(
        sender: "Recipient",
        text: "Omw",
        animationController: animationController);

    ChatMessage msg7 = ChatMessage(
        sender: "User",
        text: "Kthxbye",
        animationController: animationController);

    debugPrint("Inserting all test messages into _messages");

    _messages.insert(0, msg1);
    msg1.animationController.forward();

    _messages.insert(0, msg2);
    msg2.animationController.forward();

    _messages.insert(0, msg3);
    msg3.animationController.forward();

    _messages.insert(0, msg4);
    msg4.animationController.forward();

    _messages.insert(0, msg5);
    msg5.animationController.forward();

    _messages.insert(0, msg6);
    msg6.animationController.forward();

    _messages.insert(0, msg7);
    msg7.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.sender});
  final String text;
  final String sender;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: sender == _myName
            ? _buildUserMessage(context, _myName)
            : _buildRecipMessage(context, _recipName),
      ),
    );
  }

  Widget _buildUserMessage(BuildContext context, String sender) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildMessageBox(context, CrossAxisAlignment.end, sender),
        _buildAvatar(sender),
      ],
    );
  }

  Widget _buildRecipMessage(BuildContext context, String sender) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildAvatar(sender),
        _buildMessageBox(context, CrossAxisAlignment.start, sender),
      ],
    );
  }

  Widget _buildAvatar(String sender) {
    return new Container(
      margin: sender == _myName
          ? EdgeInsets.only(left: 16.0)
          : EdgeInsets.only(right: 16.0),
      child: new CircleAvatar(child: new Text(sender[0])),
    );
  }

  Widget _buildMessageBox(
      BuildContext context, CrossAxisAlignment align, String sender) {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          new Text(sender, style: Theme.of(context).textTheme.subhead),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            padding: const EdgeInsets.all(5.0),
            constraints: new BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.48),
            child: new Text(text),
            decoration: new BoxDecoration(
                color: sender == _myName ? Colors.blue[200] : Colors.black12,
                borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
          )
        ],
      ),
    );
  }
}
