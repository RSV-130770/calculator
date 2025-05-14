import 'package:flutter/material.dart';
import 'package:string_equation/string_equation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _entered = '';
  final List<String> _buttons=['(',')','+','-','*','7','8','9','/','4',
    '5','6','.','1','2','3'];
  String _result = '';
  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_entered, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_result, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _entered='';
                  });
                },
                child: Text('C'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    try {
                      _entered = _entered.substring(0,_entered.length - 1);
                    } on Exception catch (e) {
                      print('Exception details:\n $e');
                    } catch (e, s) {
                      print('Exception details:\n $e');
                      print('Stack trace:\n $s');
                    }
                    if (_entered.isNotEmpty) {
                      _entered = _entered.substring(0,_entered.length - 1);
                    }
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  size:10,
                  color: Colors.black,
                ),
              ),

            ],
          ),
          for(int j=0;j<4;j++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = j*4; i < (j+1)*4; i++)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _entered += _buttons[i];
                    });
                  },
                  child: Text(_buttons[i]),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _entered +='0';
                  });
                },
                child: Text('0'),
              ),
              ElevatedButton(
                onPressed: () {
                  double ttt=0;
                  try {
                    ttt=ConditionEquation().evaluateExpression(_entered);
                  } on Exception catch (e) {
                    setState(() {
                      _result = '$e';
                    });
                  }
                  setState(() {
                    _result ='=$ttt';
                  });
                },
                child: Text('='),
              ),
            ],
          ),
         ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
