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
  final FocusNode textFocus = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        iconTheme: Theme.of(context).accentIconTheme,
        title: new Text(_recipName),
        elevation:
            Theme.of(context).platform == TargetPlatform.android ? 4.0 : 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () =>
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Call Recipient"),
                  duration: new Duration(
                      seconds: 1,
                      milliseconds:
                          15), //Ms added for unique commit, remove later
                )),
          )
        ],
      ),
      body: new Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
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
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildEditText(),
              )
            ],
          ),
        ),
        decoration: Theme.of(context).platform == TargetPlatform.android
            ? null
            : BoxDecoration(
                border:
                    new Border(top: new BorderSide(color: Colors.grey[200]))),
      ),
    );
  }

  Widget _buildEditText() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(textFocus),
      child: new Container(
        decoration: BoxDecoration(
            color: Colors
                .transparent), // Added transparent fill to allow requestFocus from the entire container
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                focusNode: textFocus,
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _submit,
                decoration: new InputDecoration.collapsed(
                  hintText: "Send a message",
                ),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.android
                    ? new IconButton(
                        icon: new Icon(Icons.send,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: _isComposing
                            ? () => _submit(_textController.text)
                            : null,
                      )
                    : new CupertinoButton(
                        child: new Text("Send", style: TextStyle(color: Theme.of(context).iconTheme.color)),
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
        text: "How do I get in? The gate is locked.",
        animationController: animationController);

    ChatMessage msg4 = ChatMessage(
        sender: "Recipient",
        text: "No worries, I'll send someone to come get you right away.",
        animationController: animationController);

    ChatMessage msg5 = ChatMessage(
        sender: "User",
        text: "Alright, thanks.",
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMessageBox(context, CrossAxisAlignment.end, sender),
        _buildAvatar(context, sender),
      ],
    );
  }

  Widget _buildRecipMessage(BuildContext context, String sender) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAvatar(context, sender),
        _buildMessageBox(context, CrossAxisAlignment.start, sender),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, String sender) {
    return new Container(
      margin: sender == _myName
          ? EdgeInsets.only(left: 10.0)
          : EdgeInsets.only(right: 10.0),
      child: new CircleAvatar(
          child: new Text(sender[0],
              style: TextStyle(
                  color: sender == _myName ? Colors.white : Colors.black)),
          backgroundColor: sender == _myName
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          foregroundColor: sender == _myName
              ? Theme.of(context).accentTextTheme.title.color
              : Theme.of(context).textTheme.title.color),
    );
  }

  Widget _buildMessageBox(
      BuildContext context, CrossAxisAlignment align, String sender) {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          // new Text(sender, style: Theme.of(context).textTheme.subhead),
          new Container(
            margin: const EdgeInsets.only(top: 4.0),
            padding: const EdgeInsets.all(7.0),
            constraints: new BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.48),
            child: new Text(
              text,
              style: new TextStyle(
                  fontSize: 15.0,
                  color: sender == _myName ? Colors.white : Colors.black),
            ),
            decoration: new BoxDecoration(
                color: sender == _myName
                    ? Theme.of(context).primaryColor.withAlpha(230)
                    : Theme.of(context).accentColor.withAlpha(200),
                borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
          )
        ],
      ),
    );
  }
}
