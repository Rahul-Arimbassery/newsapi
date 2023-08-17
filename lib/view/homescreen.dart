import 'package:flutter/material.dart';
import 'package:newsapi/model/apimodel.dart';
import 'package:newsapi/view/splashscreen.dart';
import 'package:newsapi/viewmodel/fetchapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<List<Articles>>(
          future: fetchApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildFirstItem(snapshot.data![10]);
                  } else {
                    return _buildListItem(snapshot.data![index]);
                  }
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 2,
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

  Widget _buildFirstItem(Articles article) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: const Color.fromARGB(255, 33, 32, 32),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 20, bottom: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    article.urlToImage.toString(),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        article.title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(
                          height: 10), // Add spacing between the text
                      Text(
                        article.author.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(Articles article) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: 110,
        color: const Color.fromARGB(255, 33, 32, 32),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        article.author.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 159, 157, 157),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image.network(
                          article.urlToImage.toString(),
                          scale: 10,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
