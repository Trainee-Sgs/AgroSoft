import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../widgets/shared_preference_screen.dart';

class LedgerProvider extends ChangeNotifier {

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  static const String _baseUrl =
      'https://agrosoftware.in/api/mobile/index_new.php';

  // ─────────────────────────────────────────────
  // SAVE LEDGER
  // ─────────────────────────────────────────────
  Future<bool> saveLedger(Map<String, String> data) async {

    _setLoading(true);
    _message = '';

    try {

      final cid =
          (await SharedPrefService.getLedId()) ?? 0;

      // ─────────────────────────────────────────
      // MULTIPART REQUEST
      // ─────────────────────────────────────────
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(_baseUrl),
      );

      // ─────────────────────────────────────────
      // REQUIRED PARAMS — MATCH POSTMAN EXACTLY
      // ─────────────────────────────────────────
      request.fields['type']         = '50';
      request.fields['cid']          = cid.toString();


      // ── Basic Info ────────────────────────────
      request.fields['name']         = data['Contact Name']  ?? '';
      request.fields['phone']        = data['Phone']         ?? '';
      request.fields['code']         = data['Code']          ?? '';
      request.fields['cat']          = data['Category']      ?? '';
      request.fields['ledger_name']  = data['Ledger Name']   ?? '';
      request.fields['short_name']   = data['Short Name']    ?? '';
      request.fields['display_name'] = data['Display Name']  ?? '';
      request.fields['address']      = data['Address']       ?? '';
      request.fields['email']        = data['Email']         ?? '';
      request.fields['pin']          = data['Pincode']       ?? '';
      request.fields['location']     = data['Location']      ?? '';
      request.fields['credit_limit'] = data['Credit Limit']  ?? '';

      // ── Tax & Identity ────────────────────────
      request.fields['gst']          = data['GST']           ?? '';
      request.fields['adhar']        = data['Aadhaar']       ?? '';
      request.fields['pan']          = data['PAN']           ?? '';

      // ── Bank Details ──────────────────────────
      request.fields['bank_name']    = data['Bank Name']     ?? '';
      request.fields['acc_no']       = data['Account No']    ?? '';
      request.fields['ifsc']         = data['IFSC']          ?? '';
      request.fields['bank_branch']  = data['Bank Branch']   ?? '';

      // ── Account Details ───────────────────────
      request.fields['sl_no']        = data['SL No']         ?? '';
      request.fields['fl_no']        = data['FL No']         ?? '';
      request.fields['sl_no2']       = data['SL No 2']       ?? '';
      request.fields['fms']          = data['FMS']           ?? '';

      // ─────────────────────────────────────────
      // DEBUG
      // ─────────────────────────────────────────
      debugPrint('══════════════════════════════');
      debugPrint('LEDGER API FIELDS:');
      request.fields.forEach((k, v) => debugPrint('  $k : $v'));
      debugPrint('══════════════════════════════');

      // ─────────────────────────────────────────
      // SEND REQUEST
      // ─────────────────────────────────────────
      final streamedResponse =
      await request.send().timeout(
        const Duration(seconds: 30),
      );

      final response =
      await http.Response.fromStream(
        streamedResponse,
      );

      // ─────────────────────────────────────────
      // DEBUG RESPONSE
      // ─────────────────────────────────────────
      debugPrint('STATUS : ${response.statusCode}');
      debugPrint('BODY   : ${response.body}');

      // ─────────────────────────────────────────
      // STATUS CHECK
      // ─────────────────────────────────────────
      if (response.statusCode != 200) {
        return _fail('Server Error ${response.statusCode}');
      }

      // ─────────────────────────────────────────
      // EMPTY BODY
      // ─────────────────────────────────────────
      if (response.body.trim().isEmpty) {
        return _fail('Empty response from server');
      }

      // ─────────────────────────────────────────
      // JSON DECODE
      // ─────────────────────────────────────────
      final decoded = jsonDecode(response.body);

      if (decoded['error'] == false) {
        _message = decoded['error_msg'] ?? 'Saved Successfully';
        _setLoading(false);
        return true;
      }

      return _fail(decoded['error_msg'] ?? 'Save Failed');

    } on TimeoutException {
      return _fail('Request Timeout');
    } catch (e) {
      debugPrint('EXCEPTION : $e');
      return _fail(e.toString());
    }
  }

  // ─────────────────────────────────────────────
  // FAIL
  // ─────────────────────────────────────────────
  bool _fail(String msg) {
    _message = msg;
    _setLoading(false);
    return false;
  }

  // ─────────────────────────────────────────────
  // LOADING
  // ─────────────────────────────────────────────
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}