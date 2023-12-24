import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:news_app_api/Controller/everyNewsControler.dart';
import 'package:news_app_api/View/newsDetailsScreen.dart';
import 'package:news_app_api/View/widgets/newsCard.dart';

import 'Auth/LoginScreen.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EveryNewsController _everyNewsController = Get.put(EveryNewsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _everyNewsController.getEveryNewsData();
  }

  //THIS WILL HELP TO LOGOUT FROM THE APP
  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
  }
  //THIS WILL ASK TO USER IS HE OR SHE WANTS TO LOGOUT?
  void _dialogue(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Log Out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              _logOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("News App",style: TextStyle(color: Colors.white),),
        actions: [IconButton(onPressed: (){
          _dialogue();
        }, icon: Icon(Icons.logout,color: Colors.white,))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              GetBuilder<EveryNewsController>(
                builder: (everyNewsController) {
                  if(_everyNewsController.getEveryNewsInProgress){
                    return const Center(
                      child: SpinKitWaveSpinner(
                        size: 100,
                        color: Colors.blue,
                      ),
                    );
                  }else{
                    return SingleChildScrollView(
                      child: Column(children: everyNewsController.everyNewsModel.articles!.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsScreen(source: e.source!.name.toString(), author: e.author.toString(), publishedAt: e.publishedAt.toString(), urlToImage: e.urlToImage.toString(), title: e.title.toString(), description: e.description.toString(), content: e.content.toString())));
                          },
                            child: NewsCard(title: e.title.toString(), channelName: e.source!.name.toString(), date:e.publishedAt.toString(), images: e.urlToImage.toString())),
                      )).toList(),),
                    );
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
