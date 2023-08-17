import 'package:flutter/material.dart';
import 'package:newsapi/model/apimodel.dart';
import 'package:newsapi/viewmodel/fetchapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: FutureBuilder<List<Articles>>(
          future: fetchApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text((snapshot.data![index].title).toString()),
                      //Text((snapshot.data![index].description).toString()),
                      //Text((snapshot.data![index].title).toString()),
                      //Text((snapshot.data![index].title).toString()),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 35,
                ),
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
