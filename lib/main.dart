import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dogs_app/dog_model.dart';
import 'package:dogs_app/dog_list.dart';
import 'package:dogs_app/new_dog_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Rate Dogs',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /* Sample Dogs Data */
  List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'))
    ..add(Dog('Burg', 'South Pole, Earth', 'Self proclaimed hugger.'));

  Future _showNewDogForm() async {
    Dog newDog = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDogFormPage();
        },
      ),
    );
    if (newDog != null) {
      initialDoggos.add(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
        actions: [
         IconButton(
          icon: Icon(Icons.add),
          onPressed: _showNewDogForm,
        ),
      ],
      ),
      body: Container(
        child: DogList(initialDoggos),
      ),
    );
  }
}
