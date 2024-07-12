import 'package:flutter/material.dart';
InputDecoration kTextFildDecoration(String hintText)
{
return InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none
                    )
                  );
}

// TextFormField kTextFild(String hintText)
// {
//   return TextFormField(
//                   style: const TextStyle(
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: hintText,
//                     hintStyle: const TextStyle(
//                       color: Colors.grey,
//                     ),
//                     border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       borderSide: BorderSide.none
//                     )
//                   )
//                 );
// }