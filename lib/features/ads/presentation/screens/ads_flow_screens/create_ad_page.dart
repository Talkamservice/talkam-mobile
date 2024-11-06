import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CreateAdPage extends StatefulWidget {
  const CreateAdPage({super.key});

  @override
  State<CreateAdPage> createState() => _CreateAdPageState();
}

class _CreateAdPageState extends State<CreateAdPage> {

  //use this to track switch for scheduled post
  bool scheduled = false;

  String? _selectedCategory;

  final List<String> _categories = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, color: Color(0xFF1F96BC)),
                        5.horizontalSpace,
                        const Text(
                          "Select category",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        10.horizontalSpace,
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                      ],
                    ),
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  underline: const SizedBox(),
                  icon: const SizedBox.shrink(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event_note_outlined),
                      5.horizontalSpace,
                      const Text(
                        "Rules",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          const Divider(
            color: Colors.grey,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
                child: VerticalDivider(color: Colors.grey,),
              ),
              8.horizontalSpace,
              const Icon(Icons.text_fields_rounded, size: 32, color: Colors.black,),
              8.horizontalSpace,
              const SizedBox(
                height: 30,
                child: VerticalDivider(color: Colors.grey,),
              ),
              8.horizontalSpace,
              const Icon(Icons.image, size: 32, color: Colors.black,),
              8.horizontalSpace,
              const SizedBox(
                height: 30,
                child: VerticalDivider(color: Colors.grey,),
              ),
              8.horizontalSpace,
              const Icon(Icons.list, size: 32, color: Colors.black,),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          16.verticalSpace,

          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Text(
                  "Post Title",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 14,),
                ),
              ],
            ),
          ),
          8.verticalSpace,

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: "A sharp title for your post works best",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          16.verticalSpace,

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: "Write the rest of your text here.  (optional)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          16.verticalSpace,

          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Text(
                  "Tags",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
          8.verticalSpace,

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: "Add at least one tag",
                suffixIcon: const Icon(Icons.keyboard_arrow_right_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          16.verticalSpace,

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Schedule this post",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Switch(
                  value: scheduled,
                  onChanged: (bool value) {
                    setState(() {
                      scheduled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          16.verticalSpace,

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Date & Time", hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                suffixIcon: const Icon(Icons.keyboard_arrow_right_outlined),
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
