import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/components/drawerContent.dart';
import 'package:flutter_aws/services/backendService.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("AWS Demo")),
      ),
      drawer: Drawer(child: DrawerContent(),),
      body: Center(
        child: FutureBuilder(
          future: BackendService.getWeatherForecast(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Text(snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
      bottomNavigationBar: BottomAppBar(), //todo build options
    );
  }
}
