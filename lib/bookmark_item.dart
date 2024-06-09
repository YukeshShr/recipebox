import 'package:flutter/material.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({
    super.key,
    required this.id,
    required this.img,
    required this.title,
    required this.removeBookmark,
    required this.updateBookmark,
  });

  final String img;
  final String title;
  final String id;
  final void Function(String) removeBookmark;
  final VoidCallback updateBookmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Image.network(
            img,
            height: 54.0,
            width: 54.0,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 193,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFFFFFF)),
          ),
        ),
        InkWell(
          onTap: () {
            removeBookmark(id);
            updateBookmark();
          },
          child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Color(0xFF3F3F46),
              ),
              width: 65.5,
              height: 25,
              child: const Text(
                'Remove',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }
}
