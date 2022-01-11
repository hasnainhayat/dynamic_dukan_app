import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearbyShops_Tile extends StatelessWidget {
  final Color color;
  final String title;
  final String assetPath;
  final action;

  const NearbyShops_Tile({
    Key? key,
    required this.color,
    required this.title,
    required this.assetPath,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {action()},
      child: Container(
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        height: 200,
        width: 150,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  assetPath != null && assetPath.length > 0
                      ? Image.network(
                          this.assetPath,
                          height: 80,
                          width: 80,
                        )
                      : Image.asset(
                          'images/shop.png',
                          height: 80,
                          width: 80,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    this.title,
                    style: GoogleFonts.varelaRound(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: FlatButton(
                  minWidth: 1,
                  child: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
