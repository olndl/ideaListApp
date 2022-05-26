import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_of_ideas/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyNotes(),
    );
  }
}

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  Set<String> _ideas = {'собирать мёд', 'продавать шишки'};

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: _appBar(),
        body: Stack(
          children: [
            _backgroundColor(),
            _textEditIdea(context),
            Positioned(
                top: _h / 4.5,
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                    height: _h / 8,
                    child: ListView.builder(
                        itemCount: _ideas.length,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (BuildContext context, int index) {
                          return _cards(_ideas.toList()[index]);
                        })))
          ],
        ));
  }

  _appBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Strings.appTitle,
          style: TextStyle(
              fontSize: 27,
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _backgroundColor() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xffc6ffdd),
        Color(0xffFBD786),
        Color(0xfff7797d),
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
    );
  }

  Widget _textEditIdea(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.fromLTRB(_w / 8, _w / 7, _w / 8, 0),
        child: TextField(
          controller: TextEditingController(),
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Color(0xfff7797d), width: 4)),
            labelText: Strings.idea,
            prefixIcon: Icon(Icons.textsms_outlined),
          ),
          onSubmitted: (String str) {
            setState(() {
              if (str != '') {
                _ideas.add(str);
              }
            });
          },
        ));
  }

  Widget _cards(String title) {
    double _w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
      padding: EdgeInsets.all(_w / 20),
      height: _w / 4.4,
      width: _w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: _w / 15,
            child: Image.asset(Strings.imageStar),
          ),
          Container(
            alignment: Alignment.center,
            width: _w / 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}