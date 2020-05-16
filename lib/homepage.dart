import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'models/article_model.dart';
import 'models/category_model.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'new_types/ALLtypes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          'images/NewsTypes_news.png', "Entertainment", "entertainment"),
      new CategoriesModel('images/sports_news.png', "Sports", "sports"),
      new CategoriesModel('images/business_news.png', "Business", "business"),
      new CategoriesModel('images/tech_news.png', "Technology", "technology"),
      new CategoriesModel('images/science_news.png', "Science", "science"),
      new CategoriesModel('images/politics_news.png', "Politics", "politics")
    ];
    return categories;
  }

  Future<List<Article>> getData() async {
    List<Article> list;
    String link =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=018012e1dcaf4ccabb3a2dfb7ee988ac";
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

  String healthUrl = 'https://image.flaticon.com/icons/svg/2925/2925159.svg';
  String politicUrl = 'https://i.stack.imgur.com/XPOr3.png';
  String sportsUrl = 'https://i.stack.imgur.com/YN0m7.png';
  String businessUrl = 'https://i.stack.imgur.com/wKzo8.png';
  String scienceUrl = 'https://i.stack.imgur.com/Qt4JP.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('NEWS FEED'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/night.jpg"),
                          fit: BoxFit.cover)),
                  child: Text("Get the top news here"),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.greenAccent,
                child: ListView(children: [
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/hom.png"),
                    ),
                    autofocus: true,
                    title: Text("Home"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/enter.png"),
                    ),
                    title: Text("ENTERTAINMENT"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                              categoriesList[2].title,
                              categoriesList[2].newsType)));
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/politics.png"),
                    ),
                    title: Text("POLITICS"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                            categoriesList[7].title,
                            categoriesList[7].newsType,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/sport.png"),
                    ),
                    title: Text("SPORTS"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                            categoriesList[3].title,
                            categoriesList[3].newsType,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/science.png"),
                    ),
                    title: Text("SCIENCE"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                            categoriesList[6].title,
                            categoriesList[6].newsType,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/buisness.png"),
                    ),
                    title: Text("BUISNESS"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                            categoriesList[4].title,
                            categoriesList[4].newsType,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      // radius: 40,
                      backgroundImage: AssetImage("assets/images/health.png"),
                    ),
                    title: Text("Health"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewsTypes(
                            categoriesList[1].title,
                            categoriesList[1].newsType,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Programming"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
              ),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Latest News',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                letterSpacing: 3,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getData(),
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
                      stops: [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.1)
                      ],
                    ),
                  ),
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
          itemCount: 20,
          // pagination: new SwiperPagination(),
          control: new SwiperControl(),
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }
}
