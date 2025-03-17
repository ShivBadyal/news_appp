// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImage,
      newstitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsDetailsScreen({
    Key? key,
    required this.newsImage,
    required this.newstitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

   final format = DateFormat('MM-dd-yyyy');

   

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        SizedBox(
          height: height * .42,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: CachedNetworkImage(
              imageUrl: widget.newsImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => SpinKitDancingSquare(),
            ),
          ),
        ),
        
        Container(
          
          height: height * .5,
          margin: EdgeInsets.only(top: height * .4),
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
          child: ListView(
            children: [
              Text(
                widget.newstitle,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.source,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                   Text(
                    format.format(dateTime),
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: height * .03,),
              Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: height * .01,),
                  Text(widget.author,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),)
            ],
          ),
        )
      ]),
    );
  }
}
