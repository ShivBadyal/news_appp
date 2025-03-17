import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_appp/Models/news_view_model.dart';
import 'package:news_appp/view/categories_screen.dart';
import 'package:news_appp/Models/categories_news_model.dart';
import 'package:news_appp/view/news_details_scren.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, espn, techcrunch, bbcSports, bloomberg }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MM-dd-yyyy');

  String name = 'espn';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Icon(Icons.category),
        ),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.black), // Using Poppins font
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterList item) {
              if (FilterList.bbcNews == item) {
                name = "bbc-news";
              }
              if (FilterList.espn == item) {
                name = "espn";
              }
              if (FilterList.techcrunch == item) {
                name = "techcrunch";
              }
              if (FilterList.bbcSports == item) {
                name = "bbc-sport";
              }
              if (FilterList.bloomberg == item) {
                name = "bloomberg";
              }

              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem(
                value: FilterList.bbcNews,
                child: Text('BBC - News', style: GoogleFonts.poppins()),
              ),
              PopupMenuItem(
                value: FilterList.espn,
                child: Text('Espn', style: GoogleFonts.poppins()),
              ),
              PopupMenuItem(
                value: FilterList.techcrunch,
                child: Text('Techcrunch', style: GoogleFonts.poppins()),
              ),
              PopupMenuItem(
                value: FilterList.bbcSports,
                child: Text('BBC-Sports', style: GoogleFonts.poppins()),
              ),
              PopupMenuItem(
                value: FilterList.bloomberg,
                child: Text('Bloomberg', style: GoogleFonts.poppins()),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder(
              future: newsViewModel.fetchNewsChannelHeadlines(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitChasingDots(
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                newsImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newstitle: snapshot.data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                author: snapshot.data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                content: snapshot.data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * .01),
                                  height: height * 0.8,
                                  width: width * .9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 35,
                                child: Card(
                                  color: Colors.black.withOpacity(0.10),
                                  elevation: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(15),
                                    height: height * .19,
                                    width: width * .7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          width: width * 0.7,
                                          child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 2,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitChasingDots(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) => SizedBox(
                                    child: Center(
                                      child: SpinKitChasingDots(
                                        size: 40,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: height * 0.18,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
