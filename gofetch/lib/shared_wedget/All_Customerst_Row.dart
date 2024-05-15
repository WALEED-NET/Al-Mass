import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class AllCustomerstRow extends StatefulWidget {
  final info;
  final VoidCallback onTap;
   AllCustomerstRow(
      {super.key,
      required this.onTap, required this.info});

  @override
  State<AllCustomerstRow> createState() => _AllCustomerstRowState();
}

class _AllCustomerstRowState extends State<AllCustomerstRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Icon(
                Icons.person,
                weight: 70,
                size: 50,
                color: app_colors.main,
                )
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.info["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: app_colors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "phone number : ${widget.info["phone_number"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: app_colors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                     "address : ${widget.info["address"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: app_colors.secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    widget.info["total_price"] == null ? "no items add" :  "total_price : ${widget.info["total_price"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: app_colors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
