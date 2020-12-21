import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'material_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// App state containing an int counter.
class AppState with ChangeNotifier {
  int _counter = 0;

  get counter => _counter;
  set counter(int counter) {
    _counter = counter;
    notifyListeners();
  }
}

// State restoration listenable. Listens to changes to the app state
// and saves the counter value and restores it later if the Android activity
// is killed.
class _RestorableCounterState extends RestorableListenable<AppState> {
  @override
  AppState createDefaultValue() => AppState();

  @override
  AppState fromPrimitives(Object data) => AppState()..counter = data as int;

  @override
  Object toPrimitives() => value.counter;
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin {
  final _RestorableCounterState _appState = _RestorableCounterState();

  @override
  String get restorationId => 'app';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_appState, 'app_state');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: _appState.value,
        ),
      ],
      child: ScaffoldWidget(),
    );
  }
}

class ScaffoldWidget extends StatefulWidget {
  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  Widget build(BuildContext context) {
    int counter = Provider.of<AppState>(context)._counter;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text('$counter'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final AppState _appState = Provider.of<AppState>(
            context,
            listen: false,
          );
          _appState.counter = _appState.counter += 1;
        },
        child: Text('+'),
      ),
    );
  }
}
