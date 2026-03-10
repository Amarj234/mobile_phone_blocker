import 'dart:convert';
import 'package:http/http.dart' as http;

class EmiService {
  Future<bool> isEmiPaid() async {
    final response = await http.get(
      Uri.parse("https://api.example.com/emi-status"),
    );

    final data = jsonDecode(response.body);

    return data["emi_status"] == "paid";
  }
}
