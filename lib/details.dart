import 'package:flutter/material.dart';
import 'package:news_app3/webview.dart';

import 'models/article_model.dart';

class NewsDetails extends StatefulWidget {
  final Article article;
  // final String title;

  NewsDetails(
    this.article,
  );

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('suyash'),
        ),
        body: Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.network(widget.article.urlToImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.article.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.article.description,
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
                MaterialButton(
                  height: 50.0,
                  color: Colors.deepPurple,
                  elevation: 10,
                  child: Text(
                    "For more news",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            WebView(widget.article.url)));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
