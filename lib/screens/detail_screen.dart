import 'package:flutter/material.dart';
import 'package:gif_search_app/models/gif_model.dart';



class DetailScreen extends StatelessWidget {
  final GifModel gif;
  const DetailScreen({Key? key, required this.gif}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIF Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(    
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(gif.imageUrl, fit: BoxFit.contain, ),
              ),
            
              Text('Title : ${gif.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 32),
              ]
        
        ),
      ),
    );
  }
}