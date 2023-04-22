import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateQuestions(String notes) async {
  notes =
      notes.replaceAll('\\', '').replaceAll('"', '\\"').replaceAll("'", "\\'");
  var headers = {
    'Authorization': 'BEARER Nq2P42sJ1OlwOWqcbUjjP0zAKyApQSlqVrqzgBJe',
    'Content-Type': 'application/json'
  };
  var request =
      http.Request('POST', Uri.parse('https://api.cohere.ai/v1/generate'));
  request.body = json.encode({
    "model": "command-xlarge-nightly",
    "prompt":
        "Generate 1 question per line for the following note page. Add two newlines after the last question. Only include the questions in your response and the two ending newlines. Make the questions detailed and a variety of styles. Write enough questions to cover all the material in YOUR PROMPT but be consise and don't repeat questions.\n\nEXAMPLE RESPONSE (Do not use this to make questions. This is only for you to see how to structure your responses.):\nIn a capability-based access control system, what are the different methods of revoking capabilities and what challenges are associated with each method?\nWhat are the main advantages and disadvantages of using a capability-based access control system compared to an Access Control List (ACL) system?\n\n-------- YOUR PROMPT IS BELOW ---------$notes",
    "max_tokens": 1000,
    "temperature": 1,
    "k": 0,
    "stop_sequences": ["\\n\\n"],
    "return_likelihoods": "NONE"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // Read response as a string
    String responseBody = await response.stream.bytesToString();

    // Decode JSON string
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    // Access the 'generations' list and get the 'text' property of the first element
    return jsonResponse['generations'][0]['text'];
  } else {
    print(response.reasonPhrase);
    return "Error";
  }
}
