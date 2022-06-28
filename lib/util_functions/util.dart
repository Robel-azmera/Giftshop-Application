import 'dart:io';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:lezemed_mobile_app/config/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:html/parser.dart';

class Util {
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

// Check for internet connection
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  // Launching url from the app
  Future<void> launchInBrowser(String url) async {
    await canLaunch(url)
        ? await launch(
            url,
            forceSafariVC: false,
            forceWebView: false,
            headers: <String, String>{'my_header_key': 'my_header_value'},
          )
        : throw 'Could not launch $url';
  }

  Future<void> launchInWebViewOrVC(String url) async {
    await canLaunch(url)
        ? await launch(
            url,
            forceSafariVC: false,
            forceWebView: false,
            headers: <String, String>{'my_header_key': 'my_header_value'},
          )
        : throw "Could not launch $url";
  }

  // Validators
  bool validateNotEmpty(String value) {
    // checking if the value is not empty
    if (value.isEmpty || value == null) return false;
    return true;
  }

  bool validateEmail(String value) {
    // checking if the email is in a correct format
    Pattern emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp emailRegExp = new RegExp(emailPattern);
    return (!emailRegExp.hasMatch(value)) ? false : true;
  }

  bool validateName(String value) {
    // checking if the name is letter only
    Pattern namePattern = r'[a-zA-Z][a-zA-Z ]+';
    RegExp nameRegExp = new RegExp(namePattern);
    return (!nameRegExp.hasMatch(value)) ? false : true;
  }

  bool isEntriesCorrect(double advancePayment, double halflifePayment,
      double finalPayment, double retentionPayment) {
    // checking if the percentage sum up to 100%
    if (advancePayment + halflifePayment + finalPayment + retentionPayment ==
        100) return true;
    return false;
  }

  bool isNumberOnly(String value) {
    // checking if the value is number only, for phone number
    Pattern numberPattern = r'[0-9]+';
    RegExp numberRegExp = new RegExp(numberPattern);
    return (!numberRegExp.hasMatch(value)) ? false : true;
  }

  // Creating oAuth 1.0 URL
  String getOAuthURL(String requestMethod, String queryUrl) {
    String consumerKey = API.consumerKey;
    String consumerSecret = API.consumerSecret;

    String token = "";
    String url = queryUrl;
    bool containsQueryParams = url.contains("?");

    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    String parameters = "oauth_consumer_key=" +
        consumerKey +
        "&oauth_nonce=" +
        nonce +
        "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" +
        timestamp.toString() +
        "&oauth_token=" +
        token +
        "&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = Uri.splitQueryString(parameters);
    Map<dynamic, dynamic> treeMap = new SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          "=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    String method = requestMethod;
    String baseString = method +
        "&" +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url) +
        "&" +
        Uri.encodeQueryComponent(parameterString);

    String signingKey = consumerSecret + "&" + token;
    crypto.Hmac hmacSha1 =
        crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    String finalSignature = base64Encode(signature.bytes);

    String requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = url.split("?")[0] +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    }

    return requestUrl;
  }
}
