import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'location_service.dart';
import '../widgets/shared_preference_screen.dart';

class DropdownItem {
  final int id;
  final String value;
  final String name;

  DropdownItem({required this.id, required this.value, required this.name});

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      id: json['id'] ?? 0,
      value: json['value']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }
}

class DropdownProvider extends ChangeNotifier {
  static const String _baseUrl = 'https://agrosoftware.in/api/mobile/index_new.php';

  bool _isLoading = false;
  String _message = '';
  List<DropdownItem> _gstTypes = [];
  List<DropdownItem> _taxTypes = [];

  bool get isLoading => _isLoading;
  String get message => _message;
  List<DropdownItem> get gstTypes => _gstTypes;
  List<DropdownItem> get taxTypes => _taxTypes;

  // ─────────────────────────────────────────────────────────────────────────────
  // FETCH GST TYPES (Type 83)
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> fetchGstTypes() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final body = await _buildBody('83');

      debugPrint('════════════════════════════════════════');
      debugPrint('[GST DROPDOWN] REQUEST (Type 83) → $_baseUrl');
      debugPrint('[GST DROPDOWN] Body : $body');
      debugPrint('════════════════════════════════════════');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      if (response.body.trim().isEmpty) return;

      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        final List<dynamic> list = data['data'] ?? [];
        _gstTypes = list.map((item) => DropdownItem.fromJson(item)).toList();
        debugPrint('[GST DROPDOWN] ✅ Fetched ${_gstTypes.length} items');
      }
    } catch (e) {
      debugPrint('[GST DROPDOWN] ❌ EXCEPTION: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // FETCH TAX TYPES (Type 84)
  // ─────────────────────────────────────────────────────────────────────────────
  Future<void> fetchTaxTypes() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final body = await _buildBody('84');

      debugPrint('════════════════════════════════════════');
      debugPrint('[TAX DROPDOWN] REQUEST (Type 84) → $_baseUrl');
      debugPrint('[TAX DROPDOWN] Body : $body');
      debugPrint('════════════════════════════════════════');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      if (response.body.trim().isEmpty) return;

      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        final List<dynamic> list = data['data'] ?? [];
        _taxTypes = list.map((item) => DropdownItem.fromJson(item)).toList();
        debugPrint('[TAX DROPDOWN] ✅ Fetched ${_taxTypes.length} items');
      }
    } catch (e) {
      debugPrint('[TAX DROPDOWN] ❌ EXCEPTION: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────────────────────────
  Future<Map<String, String>> _buildBody(String type) async {
    final double lat = LocationService.fetched ? LocationService.lt : 0.0;
    final double lng = LocationService.fetched ? LocationService.ln : 0.0;

    int? savedCid = await SharedPrefService.getLedId();
    int? savedUid = await SharedPrefService.getUserId();

    if (savedCid == null || savedCid == 456 || savedCid == 0) savedCid = 49542621;
    if (savedUid == null || savedUid == 789 || savedUid == 0) savedUid = 2;

    return {
      'type': type,
      'cid': savedCid.toString(),
      'device_id': '123',
      'lt': lat.toString(),
      'ln': lng.toString(),
      'uid': savedUid.toString(),
    };
  }
}
