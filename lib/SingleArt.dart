import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';

class SingleArt extends StatelessWidget {
  QueryResult _result;
  BuildContext _context;
  Size _size;
  int _index;
  SingleArt(QueryResult result, Size size, BuildContext context, int index) {
    _result = result;
    _context = context;
    _size = size;
    _index = index;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    String image = "https://yonmoyonmo.pythonanywhere.com/files/" +
        _result.data['allPhotos'][_index]['image'];
    String title = _result.data['allPhotos'][_index]['title'];
    String comment = _result.data['allPhotos'][_index]['comment'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Mom's Art Gallery",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fondamento',
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'NanumMyeongjo',
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              alignment: Alignment.centerRight,
              child: Text(
                comment,
                style: TextStyle(
                  fontFamily: 'NanumMyeongjo',
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).accentColor,
                    blurRadius: 10.0,
                    offset: Offset(10.0, 10.0),
                  ),
                ],
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: FadeInImage.memoryNetwork(
                width: double.infinity,
                height: _size.height * 0.7,
                placeholder: kTransparentImage,
                image: image,
              ),
            ),
          ],
        ));
  }
}
