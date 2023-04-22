import 'dart:convert';
import 'package:http/http.dart' as http;

// Create a structure to represent a page ID and created time pair
class NotionPage {
  String id;
  DateTime createdTime;

  NotionPage({required this.id, required this.createdTime});
}

// Database Query
Future<List<NotionPage>> fetchPagesFromNotion(String databaseId) async {
  var headers = {
    'Authorization':
        'Bearer secret_JfctSKJ87pSbMT4jDpXgPlzF75HI31TKbnnzsyIe2t6',
    'Notion-Version': '2022-06-28',
    'Content-Type': 'application/json',
  };

  var response = await http.post(
    Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
    headers: headers,
    body: json.encode({}),
  );

  List<NotionPage> notionPages = [];
  for (var page in json.decode(response.body)['results']) {
    notionPages.add(NotionPage(
        id: page['id'], createdTime: DateTime.parse(page['created_time'])));
  }

  if (response.statusCode == 200) {
    return notionPages;
  } else {
    throw Exception(
        'Failed to fetch pages from Notion: ${response.reasonPhrase}');
  }
}

// Fetch Block Children
Future<String> fetchTextFromPage(String pageID) async {
  var headers = {
    'Authorization':
        'Bearer secret_JfctSKJ87pSbMT4jDpXgPlzF75HI31TKbnnzsyIe2t6',
    'Notion-Version': '2022-06-28',
  };

  var response = await http.get(
    Uri.parse(
        'https://api.notion.com/v1/blocks/$pageID/children?page_size=100'),
    headers: headers,
  );

  String outputText = '';

  for (var block in json.decode(response.body)['results']) {
    Map<String, dynamic> blockMap = block;
    MapEntry<String, dynamic> lastEntry = blockMap.entries.last;

    String lastKey = lastEntry.key;
    for (var textItem in block[lastKey]['rich_text']) {
      outputText += textItem['plain_text'];
    }
  }

  if (response.statusCode == 200) {
    return outputText;
  } else {
    throw Exception('Failed to fetch block children: ${response.reasonPhrase}');
  }
}
