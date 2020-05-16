import 'dart:convert';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app3/models/article_model.dart';
import 'package:news_app3/models/category_model.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import '../details.dart';

class NewsTypes extends StatefulWidget {
  final String title;
  final String newsType;

  NewsTypes(this.title, this.newsType);
  @override
  _NewsTypesState createState() => _NewsTypesState();
}

class _NewsTypesState extends State<NewsTypes> {
  List<CategoriesModel> categoriesList;

  @override
  void initState() {
    categoriesList = new List<CategoriesModel>();
    categoriesList = loadCategories();
    super.initState();
  }

  List<CategoriesModel> loadCategories() {
    var categories = <CategoriesModel>[
      //adding all the categories of news in the list
      new CategoriesModel('images/top_news.png', "Top Headlines", "top_news"),
      new CategoriesModel('images/health_news.png', "Health", "health"),
      new CategoriesModel(
          'images/NewsTypes_news.png', "NewsTypes", "NewsTypes"),
      new CategoriesModel('images/sports_news.png', "Sports", "sports"),
      new CategoriesModel('images/business_news.png', "Business", "business"),
      new CategoriesModel('images/tech_news.png', "Technology", "technology"),
      new CategoriesModel('images/science_news.png', "Science", "science"),
      new CategoriesModel('images/politics_news.png', "Politics", "politics")
    ];
    return categories;
  }

  Future<List<Article>> getData(String newsType) async {
    List<Article> list;
    String link =
        "https://newsapi.org/v2/top-headlines?country=in&category=$newsType&apiKey=018012e1dcaf4ccabb3a2dfb7ee988ac";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Latest News',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getData(widget.newsType),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? listViewWidget(snapshot.data, context)
                      : Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }

  void _onTapItem(BuildContext context, Article article) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsDetails(
              article,
            )));
  }

  Widget listViewWidget(List<Article> article, context) {
    double height;
    double width;
    height = MediaQuery.of(context).size.height / 1.5;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: new ConstrainedBox(
        constraints: new BoxConstraints.loose(new Size(width, height)),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _onTapItem(context, article[index]),
              child: Container(
                margin: EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${article[index].urlToImage}'),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.1)
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          '${article[index].title}',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplay: false,

          itemCount: article.length,
          // pagination: new SwiperPagination(),
          control: new SwiperControl(),
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }
}
