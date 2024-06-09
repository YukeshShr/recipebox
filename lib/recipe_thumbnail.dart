import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class RecipeThumbnail extends StatefulWidget {
  const RecipeThumbnail({
    super.key,
    required this.id,
    required this.img,
    required this.title,
    required this.addBookmark,
  });

  final String img;
  final String title;
  final String id;
  final void Function(String, String, String) addBookmark;

  @override
  State<RecipeThumbnail> createState() => _RecipeThumbnailState();
}

class _RecipeThumbnailState extends State<RecipeThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.img,
                height: 166.0,
                width: 166.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.addBookmark(widget.id, widget.title, widget.img);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF404040),
                    ),
                    width: 23,
                    height: 23,
                    child: const HeroIcon(
                      HeroIcons.bookmark,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
