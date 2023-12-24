import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.title,
    required this.channelName,
    required this.date,
    required this.images,
  });

  final String images;
  final String title;
  final String channelName;
  final String date;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 170,
      width: double.infinity,
      child: Row(
        children: [
          Container(
              height: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: images,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * .18,
                    width: MediaQuery.sizeOf(context).width * .30,
                    placeholder: (context, url) => Container(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  ))),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height * .20,
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black),
                    maxLines: 3,
                  ),
                  SizedBox(height: 5),
                  Text(
                    channelName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.indigo),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  Text(
                    date,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
