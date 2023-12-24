import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/everyNewsModel.dart';

class NewsDetailsScreen extends StatefulWidget {
   NewsDetailsScreen({Key? key, required this.source,required this.author,required this.publishedAt,required this.urlToImage,required this.title,required this.description,required this.content}) : super(key: key);
  String source;
  String author;
  String title;
  String description;
  String urlToImage;
  String publishedAt;
  String content;


  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details News"),),
      body: Column(children: [
        ClipRRect(
          child:CachedNetworkImage(
            imageUrl: widget.urlToImage,
            height: MediaQuery.sizeOf(context).height * 0.3,
            fit: BoxFit.cover,
          ) ,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(widget.title,style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(widget.source,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
            Text(widget.publishedAt,style: TextStyle(fontSize: 14),)
          ],),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.description,style: TextStyle(fontSize: 14),),
        )

      ],),
    );
  }
}
