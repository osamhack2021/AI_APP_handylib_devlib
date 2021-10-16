import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class UnitBookDisplay extends StatelessWidget {
  /*const UnitBookDisplay({
    Key? key,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);*/
  final UnitBook? bookData;
  final double? imageHeight;
  final double? imageWidth;

  const UnitBookDisplay({this.bookData, this.imageHeight, this.imageWidth});

  @override
  Widget build(BuildContext context) {
    //bookDataReplace();
    //debugPrint('cover : ${bookData!.coverUrl!}');
    //debugPrint('cover : ${bookData!.coverUrl!.replaceAll('\\/', '/')}' );
    if (bookData == null) debugPrint('bookData is null!!');
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    DetailScreen(book: convertUnitBooktoBook(bookData!)),
              ),
            ); /*
            Navigator.of(context).pushNamed(
              '/home/unitlib/book-detail',
              arguments: bookData,
            );*/
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            height: imageHeight,
            width: imageWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: (bookData!.coverUrl == null)
                  ? const Image(
                      image: AssetImage('assets/images/default_book_cover_image.png'),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: "http://175.210.134.48:5000/" +
                          bookData!.coverUrl!.replaceAll('\\/', '/'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        SizedBox(
          child: Text((bookData!.title == null) ? 'unNamed' : bookData!.title!,
              overflow: TextOverflow.ellipsis),
          width: imageWidth,
        ),
      ],
    );
  }
}
