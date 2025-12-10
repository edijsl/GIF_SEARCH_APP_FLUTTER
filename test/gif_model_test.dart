import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/models/gif_model.dart';

void main() {
    test('GifModel should parse JSON correctly', () {
      final json={
        'id': 'abc123',
        'title': 'Cat',
        'images': {
          'fixed_height': {
            'url': 'https://media.giphy.com/media/abc123/200.gif'
          }
        }
      };
      final result = GifModel.fromJson(json);

      expect(result.id, 'abc123');
      expect(result.title, 'Cat');
      expect(result.imageUrl, 'https://media.giphy.com/media/abc123/200.gif');
    });
    test('GifModel should handle empty title', () {
      final json={
        'id': 'def456',
        'title': '',
        'images': {
          'fixed_height': {
            'url': 'https://media.giphy.com/media/def456/200.gif'
          }
        }
      };
      final result = GifModel.fromJson(json);

      expect(result.id, 'def456');
      expect(result.title, '');
      expect(result.imageUrl, 'https://media.giphy.com/media/def456/200.gif');
    });

    test('should create list of GifModels from JSON array', () {
      final jsonArray = [
        {'id': '1', 'title': 'Dog', 'images': {'fixed_height': {'url': 'https://media.giphy.com/media/1/200.gif'}}},
        {'id': '2', 'title': 'Cat', 'images': {'fixed_height': {'url': 'https://media.giphy.com/media/2/201.gif'}}},
      ];

      final gifs = jsonArray.map((json) => GifModel.fromJson(json)).toList();

      expect(gifs.length, 2);
      expect(gifs[0].id, '1');
      expect(gifs[0].title, 'Dog');
      expect(gifs[0].imageUrl, 'https://media.giphy.com/media/1/200.gif');
      expect(gifs[1].id, '2');
      expect(gifs[1].title, 'Cat');
      expect(gifs[1].imageUrl, 'https://media.giphy.com/media/2/201.gif');
    });
  }