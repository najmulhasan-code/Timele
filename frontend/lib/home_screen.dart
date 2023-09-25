import 'dart:convert';
import 'dart:ui';
import 'models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/api.dart';
import 'package:frontend/widgets/post_container.dart';
import 'package:frontend/utils/methods.dart';

HelperFunction helperFunction = HelperFunction();

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Paragraph> post = [];
  bool isLoading = true;

  //ShowModel function
  void _showModel() {
    String title = "";
    String description = "";
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Title",
                        hintText: 'Type...',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          hintText: 'Type...',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple)),
                      onPressed: () {},
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        });
  }

  //initState
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Timele',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.deepPurple.shade500,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          )),
      body: FutureBuilder(
        future: helperFunction.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget widget = const Text("");
          if (snapshot.hasData) {
            widget = SingleChildScrollView(
              child: Column(
                children: snapshot.data.map<Widget>((e) {
                  return PostContainer(
                    id: e.id,
                    title: e.title.toString(),
                    description: e.description.toString(),
                    onPress: () {},
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            widget = const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            widget = const Center(
              child: Text("Something Wrong!"),
            );
          }
          return widget;
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showModel();
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurpleAccent,
          size: 30,
        ),
      ),
    );
  }
}
