import 'package:note_taking_app/model/note_model.dart';
import 'package:note_taking_app/presentation/pages/note_listing_page.dart';
import 'package:flutter/material.dart';

class FolderWidget extends StatefulWidget {
  final String title;
  final String noteCount;
  final List<NoteModel> notes;
  const FolderWidget({
    super.key,
    required this.title,
    required this.noteCount,
    required this.notes,
  });

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteListingPage(
              title: widget.title,
              notes: widget.notes,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFF6B4EFF).withOpacity(0.1),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/${widget.title}.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFF292150),
                        fontSize: 16,
                        fontFamily: 'Nunito_Black',
                      ),
                    ),
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        fontFamily: 'Nunito_Regular',
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 0,
            right: 0,
            child: ClipPath(
              clipper: FolderClipper(),
              child: Container(
                width: 170 * 0.5, // Adjust width as needed (approx 23.5%)
                height: 170 * 0.3, // Adjust height as needed (approx 12%)
                color: Color(0xFFF9F8FD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FolderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(
        size.width, size.height * 0.12); // Adjusted for tab height (approx 12%)
    path.quadraticBezierTo(size.width, size.height * 0.3,
        size.width - size.width * 0.1, size.height * 0.3); // Curved corner
    path.lineTo(size.width * 0.2, size.height * 0.3); // Tab top edge
    path.lineTo(0, 0);
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(20),
      clockwise: false,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
