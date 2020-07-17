import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'MainScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: "https://yonmoyonmo.pythonanywhere.com/graphqlapi/");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: InMemoryCache()),
    );
    return GraphQLProvider(
      child: CacheProvider(
        child: MainScreen(),
      ),
      client: client,
    );
  }
}
