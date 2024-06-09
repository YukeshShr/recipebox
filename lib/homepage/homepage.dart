import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipebox/data.dart';
import 'package:recipebox/homepage/components/bookmark_item.dart';
import 'package:recipebox/homepage/components/recipe_thumbnail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Map<String, List<String>>
      bookmarks; //Recipe ID is the Key and Recipe Title and Image URL are the values

  // Initialises the state and sets bookmarks to empty Map.
  @override
  void initState() {
    super.initState();
    bookmarks = {};
  }

  // Bookmarks a recipe
  void addBookmark(String id, String title, String img) {
    setState(() {
      bookmarks[id] = [title, img];
    });
  }

  // Updates bookmark
  void updateBookmark() {
    setState(() {
      bookmarks = bookmarks;
    });
  }

  // Constructs and displays the bottom modal sheet
  // Bottom Modal Sheet displays the bookmarked recipes
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void removeBookmark(String id) {
              setState(() {
                bookmarks.remove(id);
              });
            }

            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: Color(0xFF09090B),
              ),
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        child: const Icon(
                          Icons.close,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    bookmarks.isEmpty
                        ? const Text(
                            'No Recipes have been bookmarked',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox(
                            height: 230,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 15);
                              },
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bookmarks.length,
                              itemBuilder: (context, index) {
                                String key = bookmarks.keys.elementAt(index);
                                return BookmarkItem(
                                  id: key,
                                  title: bookmarks[key]![0],
                                  img: bookmarks[key]![1],
                                  removeBookmark: removeBookmark,
                                  updateBookmark: updateBookmark,
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RECIPEBOX',
          style: TextStyle(
              letterSpacing: 6.0,
              color: Color(0xFF27272A),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Color(0xFF404040),
                ),
                tooltip: 'Show Bookmarked Recipes',
                onPressed: () {
                  _showBottomSheet(context);
                },
              ),
              Positioned(
                right: 13.0,
                top: 15.0,
                child: Container(
                  width: 13.0,
                  height: 13.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFDC2626),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    '${bookmarks.length}',
                    style: const TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: RecipesBody(
        addBookmark: addBookmark,
      ),
    );
  }
}

class RecipesBody extends StatelessWidget {
  const RecipesBody({super.key, required this.addBookmark});

  final void Function(String, String, String) addBookmark;

  // Sends GET request to URL with basic auth for the recipes.
  Future<Recipes> fetchRecipes() async {
    String username = 'mob-api';
    String password = '9r7rey5567ce0m7hbt1u';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(
        Uri.parse('https://api.mob.co.uk/task/recipes.json'),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      return Recipes.fromJson(jsonDecode(response.body)['recipes']);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, List<String>> data = snapshot.requireData.getRecipes();
          return Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String key = data.keys.elementAt(index);
                  return RecipeThumbnail(
                    id: key,
                    title: data[key]![0],
                    img: data[key]![1],
                    addBookmark: addBookmark,
                  );
                },
              ));
        }
        return const SizedBox();
      },
    );
  }
}
