import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PostBloc(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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

  PostBloc postBloc;

  @override
  void initState() {
    postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(Fetch());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          print(state);
          if (state is PostUnloaded) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is PostLoadError) {
            return Center(child: Text('Failed to fetch'),);
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(child: Text('No Data'),);
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    '${state.posts[index].id}',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  title: Text(state.posts[index].title),
                  isThreeLine: true,
                  subtitle: Text(state.posts[index].content),
                  dense: true,
                );
              },
              itemCount: state.posts.length,
            );
          }
        },
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
