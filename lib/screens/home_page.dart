import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Stack(
        children: [
           Container(
             color: Colors.red,
             child: SizedBox(
              height: MediaQuery.of(context).size.height / 2
          ),
           ),
          Container(
            color: Colors.blue,
            child: SizedBox(

              height: MediaQuery.of(context).size.height / 2,
              child: DraggableScrollableSheet(
                initialChildSize: 1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 15,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: Colors.amber,
                                title: const Text("title"),
                                leading: Text(index.toString()),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
