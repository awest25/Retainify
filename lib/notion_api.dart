import 'dart:convert';
import 'package:http/http.dart' as http;

// Create a structure to represent a page ID and created time pair
class NotionPage {
  String name;
  String id;
  DateTime createdTime;

  NotionPage({required this.name, required this.id, required this.createdTime});
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
        name: page['properties']['Name']['title'].isEmpty
            ? ''
            : page['properties']['Name']['title'][0]['plain_text'],
        id: page['id'],
        createdTime: DateTime.parse(page['created_time'])));
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

  // Supported types: paragraph, callout, equation (BUT it just says "expression"), heading_3, heading_2, heading_1, code
  var supportedTypes = [
    'paragraph',
    'callout',
    'heading_3',
    'heading_2',
    'heading_1',
    'code'
  ];

  for (var block in json.decode(response.body)['results']) {
    String blockType = block['type'];
    if (!supportedTypes.contains(blockType)) {
      continue;
    }
    if (blockType == 'equation') {
      outputText += block[blockType]['expression'];
      outputText += '\n';
      continue;
    }

    for (var textItem in block[blockType]['rich_text']) {
      outputText += textItem['plain_text'];
      outputText += '\n';
    }
    outputText += '\n';
  }

  if (response.statusCode == 200) {
    return outputText;
  } else {
    throw Exception('Failed to fetch block children: ${response.reasonPhrase}');
  }
}
