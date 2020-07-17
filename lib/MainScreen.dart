import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'SingleArt.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String query = r"""
  query{
  allPhotos{
    title
    comment
    image
  }
}
  """;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Query(
        options: QueryOptions(
          documentNode: gql(query),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/OPSTUDIOLOGO.jpg'),
              ),
            );
          }
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
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.list),
                tooltip: 'View as a list',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => _buildList(result, context, size)));
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.bookmark),
                  tooltip: 'Open Source License',
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LicensePage()));
                  },
                ),
              ],
            ),
            body: _mainScreenBuilder(result, size, context),
          );
        },
      ),
    );
  }
}

Widget _mainScreenBuilder(QueryResult result, Size size, BuildContext context) {
  List pictures = result.data['allPhotos'];
  int length = pictures.length;
  return GridView.builder(
    itemCount: length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemBuilder: (BuildContext context, int index) {
      String image = "https://yonmoyonmo.pythonanywhere.com/files/" +
          result.data['allPhotos'][index]['image'];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SingleArt(result, size, context, index);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).accentColor,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[400],
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: FadeInImage.memoryNetwork(
                width: size.width * 0.37,
                height: 160,
                placeholder: kTransparentImage,
                image: image,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildList(QueryResult result, BuildContext context, Size size) {
  List pictures = result.data['allPhotos'];
  int length = pictures.length;
  return Container(
    color: Colors.white,
    width: size.width,
    child: ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        String image = "https://yonmoyonmo.pythonanywhere.com/files/" +
            result.data['allPhotos'][index]['image'];
        String title = result.data['allPhotos'][index]['title'];
        String comment = result.data['allPhotos'][index]['comment'];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SingleArt(result, size, context, index);
            }));
          },
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListTile(
              leading: FadeInImage.memoryNetwork(
                width: 100,
                height: 100,
                placeholder: kTransparentImage,
                image: image,
              ),
              title: Text(title),
              subtitle: Text(comment),
              isThreeLine: true,
            ),
          ),
        );
      },
    ),
  );
}
