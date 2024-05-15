import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class roundTextWithOnChanged extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final void Function(String)? onSubmitted;

  const roundTextWithOnChanged(
      {super.key,
      required this.hintText,
      this.controller,
      this.keyboardType,
      this.bgColor,
      this.left,
      this.obscureText = false, 
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // look if there a value for bgColor take it , and if there is not take this after ??
        color: bgColor ?? app_colors.placeholder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              // tell the compiler that the value of the left is not null
              child: left!,
            ),
          // we use expanded here to make the icon take her size and the textfiled take the all of the left (باقي المساحة)
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hintText,
                  // why we don,t use the prefixIcon attribute ?
                  // >> because is not work with us as we want , because we put it inside container widget here
                  // prefixIcon: left,
                  hintStyle: TextStyle(
                    color: app_colors.main,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  
                  ),
                  // onChanged: onChanged,
                  onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}

class roundtext extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final String? initialError; // Optional initial error message
  final String? Function(String)? validator; // Validator function parameter

  const roundtext({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.bgColor,
    this.left,
    this.obscureText = false,
    this.initialError,
    this.validator,
  });

  @override
  State<roundtext> createState() => _roundtextState();
}

class _roundtextState extends State<roundtext> {
  String _errorMessage = ""; // State variable for error message

  String? _validateInput(String value) {
    if (widget.validator != null) {
      return widget.validator!(value); // Use provided validator if available
    } else {
      return null; // No specific validator, assume no error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.bgColor ?? app_colors.textFiled,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              if (widget.left != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: widget.left!,
                ),
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: app_colors.textFiled,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _errorMessage = _validateInput(value) ?? ""; // Update error message
                  }),
                ),
              ),
            ],
          ),
        ),
        if (_errorMessage.isNotEmpty) // Only show error if message exists
          Positioned(
            bottom: 0.0, // Adjust positioning as needed
            right: 0.0,
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}

class RoundTitleTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final bool isInputEnabled;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? backGroundColor;
  final Widget? left;

  const RoundTitleTextfield(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.isInputEnabled = false,
      this.keyboardType,
      this.backGroundColor,
      this.left,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: backGroundColor ?? app_colors.textFiled,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: left!,
            ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  alignment: Alignment.topLeft,
                  child: TextField(
                    // enabled: isInputEnabled,

                    autocorrect: false,
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: InputBorder.none,
                      enabled: isInputEnabled,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                          color: app_colors.placeholder,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style:
                        TextStyle(color: app_colors.placeholder, fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class SearchBarCustom extends StatelessWidget {
  final Function(String) onSearch;
  final String hintText;

  const SearchBarCustom({Key? key, required this.onSearch, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onChanged: onSearch,
    );
  }
}
