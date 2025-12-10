import 'package:flutter/material.dart';
import 'package:gif_search_app/models/gif_model.dart';
import 'package:gif_search_app/screens/detail_screen.dart';
import '../services/giphy_service.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  int searchOffset = 0;
  List<GifModel> gifs = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;
  Timer? _debounceTimer;
  ScrollController scrollController = ScrollController();
  bool hasSearched = false;

@override
void initState() {
  super.initState();
  scrollController.addListener(() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingMore) {
      searchOffset += 25; 
      searchGifs();
    }
  });
}

Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.first != ConnectivityResult.none;
  }
  Future<void> searchGifs() async {
    final hasInternet = await hasInternetConnection();

    if (!hasInternet) {
      setState(() {
        errorMessage = 'No internet connection. Please check your network.';
        isLoading = false;
        isLoadingMore = false;
      });
      return;
    }
    setState(() {
      if (searchOffset == 0) {
        isLoading = true;
      } else {
        isLoadingMore = true;
      }
      
      errorMessage = null;
    });
    
    try {
      final service = GiphyService();
      final results = await service.getGifs(searchQuery, searchOffset);
      
      setState(() {
        gifs.addAll(results);
        isLoading = false;
        isLoadingMore = false;
      });

      print('Found ${gifs.length} Gifs!');
    } catch (e) {
      print('Error: $e');
      setState(() {
        errorMessage = 'Failed to load GIFs. Please check your internet connection.';
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIF Search', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Gifs...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[250],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0), 
                  borderSide: BorderSide.none,
                  ),
                
              ),
              onChanged: (text) {
                searchQuery = text;

                _debounceTimer?.cancel();
                _debounceTimer = Timer(Duration(milliseconds: 500), () {
                  if (searchQuery.isNotEmpty) {
                  searchOffset = 0;
                  gifs.clear();
                  searchGifs();
                  hasSearched = true;
                  } else {
                    setState(() {
                      gifs.clear();
                      hasSearched = false;
                    });
                  }
              });
              
              }),
              
            const SizedBox(height: 20),
            if (errorMessage != null) 
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.red[100],
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red[900]),

                ),
              ),
            Expanded(
              child: Column(
                children: [
                  if (isLoading)
                    const Expanded(child: Center(child: CircularProgressIndicator())),
                  if (gifs.isNotEmpty)
                    Expanded(
                      child : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (orientation == Orientation.landscape) ? 4 : 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                      itemCount: gifs.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        final gif = gifs[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(gif: gif),
                              ),
                            );
                          },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            gif.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                        );
                      },
                  ),
            ),
                  if (isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                    if (!isLoading && gifs.isEmpty)
                       Expanded(
                        child: Center(
                          child: Text(hasSearched ? 'No GIFs Found' : 'Use Search to find GIFs'),
                        ),
                      ),
                ],
              ),
            ),
          ]),
      ),
    );
  }
}