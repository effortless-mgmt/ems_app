import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

const String _name = "Temp";

class ChatPage extends StatefulWidget {
  @override
  State createState() => new ChatPageState();
}

class ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Chat"),
          elevation:
              Theme.of(context).platform == TargetPlatform.android ? 4.0 : 0.0),
      body: new Container(
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
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                  controller: _textController,
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
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
