import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

// class MenuItemRow extends StatelessWidget {
//   final Map menuObject;
//   final VoidCallback onTap;
//   const MenuItemRow({super.key, required this.menuObject, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: InkWell(
//         onTap: onTap,
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             Image.asset(
//               menuObject["image"].toString(),
//               width: double.maxFinite,
//               height: 120,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               width: double.maxFinite,
//               height: 200,
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                 Colors.transparent,
//                 Colors.transparent,
//                 Colors.black
//               ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         menuObject["name"],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: app_colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700),
//                       ),
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             "assets/img/rate.png",
//                             width: 10,
//                             height: 10,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             menuObject["rate"],
//                             textAlign: TextAlign.center,
//                             style:
//                                 TextStyle(color: app_colors.main, fontSize: 11),
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             menuObject["type"],
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: app_colors.white, fontSize: 11),
//                           ),
//                           Text(
//                             " . ",
//                             textAlign: TextAlign.center,
//                             style:
//                                 TextStyle(color: app_colors.main, fontSize: 11),
//                           ),
//                           Text(
//                             menuObject["food_type"],
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: app_colors.white, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 22,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class CustomListTile extends StatelessWidget {
  final Widget? leading; // Optional leading widget
  final Text? title; // Required title text
  final Widget? subTitle; // Optional subtitle text
  final VoidCallback onTap; // Optional tap event handler
  final Function? onLongPress; // Optional long press event handler
  final Function? onDoubleTap; // Optional double tap event handler
  final Widget? trailing; // Optional trailing widget
  final Color? tileColor; // Optional tile background color
  final double? height; // Required height for the custom list tile

  // Constructor for the custom list tile
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    required this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.tileColor,
    required this.height, // Make height required for clarity
  });

  @override
  Widget build(BuildContext context) {
    return Material( // Material design container for the list tile
      color: tileColor, // Set background color if provided
      child: InkWell( // Tappable area with event handlers
        onTap: onTap, // Tap event handler
        onDoubleTap: () => onDoubleTap, // Double tap event handler
        onLongPress: () => onLongPress, // Long press event handler
        child: SizedBox( // Constrain the size of the list tile
          height: height, // Set custom height from constructor
          child: Row( // Row layout for list item content
            children: [
              Padding( // Padding for the leading widget
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: leading, // Display leading widget
              ),
              Expanded( // Expanded section for title and subtitle
                child: Padding(
                  padding: const EdgeInsets.only(top:  26.0),
                  child: Column( // Column layout for title and subtitle
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                    children: [
                      title ?? const SizedBox(), // Display title or empty space
                      const SizedBox(height: 10), // Spacing between title and subtitle
                      subTitle ?? const SizedBox(), // Display subtitle or empty space
                    ],
                  ),
                ),
              ),
              Padding( // Padding for the trailing widget
                padding: const EdgeInsets.all(12.0),
                child: trailing, // Display trailing widget
              )
            ],
          ),
        ),
      ),
    );
  }
}