/*
 * esc_pos_utils
 * Created by Andrey U.
 * 
 * Copyright (c) 2019-2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:convert' show json;
//import 'dart:convert' show utf8;
//import 'package:flutter/services.dart' show rootBundle;

class CodePage {
  CodePage(this.id, this.name);
  int id;
  String name;
}

class CapabilityProfile {
  CapabilityProfile._internal(this.name, this.codePages);

  /// Public factory
  static Future<CapabilityProfile> load({String name = 'default'}) async {
    Map capabilities = json.decode(content);

    var profile = capabilities['profiles'][name];

    if (profile == null) {
      throw Exception("The CapabilityProfile '$name' does not exist");
    }

    List<CodePage> list = [];
    profile['codePages'].forEach((k, v) {
      list.add(CodePage(int.parse(k), v));
    });

    // Call the private constructor
    return CapabilityProfile._internal(name, list);
  }

  String name;
  List<CodePage> codePages;

  int getCodePageId(String? codePage) {
    // if (codePages == null) {
    //   throw Exception("The CapabilityProfile isn't initialized");
    // }

    return codePages
        .firstWhere((cp) => cp.name == codePage,
            orElse: () => throw Exception(
                "Code Page '$codePage' isn't defined for this profile"))
        .id;
  }

  static Future<List<dynamic>> getAvailableProfiles() async {
    // final content = await rootBundle
    //     .loadString('packages/esc_pos_utils/resources/capabilities.json');
    Map capabilities = json.decode(content);

    var profiles = capabilities['profiles'];

    List<dynamic> res = [];

    profiles.forEach((k, v) {
      res.add({
        'key': k,
        'vendor': v['vendor'] is String ? v['vendor'] : '',
        'model': v['model'] is String ? v['model'] : '',
        'description': v['description'] is String ? v['description'] : '',
      });
    });

    return res;
  }
}

const content = '''
{
  "profiles": {
    "default": {
      "codePages": {
        "0": "CP437",
        "1": "CP932",
        "2": "CP850",
        "3": "CP860",
        "4": "CP863",
        "5": "CP865",
        "6": "Unknown",
        "7": "Unknown",
        "8": "Unknown",
        "11": "CP851",
        "12": "CP853",
        "13": "CP857",
        "14": "CP737",
        "15": "ISO_8859-7",
        "16": "CP1252",
        "17": "CP866",
        "18": "CP852",
        "19": "CP858",
        "20": "Unknown",
        "21": "CP874",
        "22": "Unknown",
        "23": "Unknown",
        "24": "Unknown",
        "25": "Unknown",
        "26": "Unknown",
        "30": "TCVN-3-1",
        "31": "TCVN-3-2",
        "32": "CP720",
        "33": "CP775",
        "34": "CP855",
        "35": "CP861",
        "36": "CP862",
        "37": "CP864",
        "38": "CP869",
        "39": "ISO_8859-2",
        "40": "ISO_8859-15",
        "41": "CP1098",
        "42": "CP774",
        "43": "CP772",
        "44": "CP1125",
        "45": "CP1250",
        "46": "CP1251",
        "47": "CP1253",
        "48": "CP1254",
        "49": "CP1255",
        "50": "CP1256",
        "51": "CP1257",
        "52": "CP1258",
        "53": "RK1048",
        "66": "Unknown",
        "67": "Unknown",
        "68": "Unknown",
        "69": "Unknown",
        "70": "Unknown",
        "71": "Unknown",
        "72": "Unknown",
        "73": "Unknown",
        "74": "Unknown",
        "75": "Unknown",
        "82": "Unknown",
        "254": "Unknown",
        "255": "Unknown"
      },
      "vendor": "Generic",
      "model": "Default",
      "description": "Default ESC/POS profile"
    },

    "XP-N160I": {
      "codePages": {
        "0": "CP437",
        "1": "CP932",
        "2": "CP850",
        "3": "CP860",
        "4": "CP863",
        "5": "CP865",
        "6": "CP1252",
        "7": "CP737",
        "8": "CP862",
        "9": "Unknown",
        "10": "Unknown",
        "16": "CP1252",
        "17": "CP866",
        "18": "CP852",
        "19": "CP858",
        "20": "Unknown",
        "21": "Unknown",
        "22": "Unknown",
        "23": "Unknown",
        "24": "CP747",
        "25": "CP1257",
        "27": "CP1258",
        "28": "CP864",
        "29": "CP1001",
        "30": "Unknown",
        "31": "Unknown",
        "32": "CP1255",
        "50": "CP437",
        "51": "CP932",
        "52": "CP437",
        "53": "CP858",
        "54": "CP858",
        "55": "CP860",
        "56": "CP861",
        "57": "CP863",
        "58": "CP865",
        "59": "CP866",
        "60": "CP855",
        "61": "CP857",
        "62": "CP862",
        "63": "CP864",
        "64": "CP737",
        "65": "CP851",
        "66": "CP869",
        "67": "CP928",
        "68": "CP772",
        "69": "CP774",
        "70": "CP874",
        "71": "CP1252",
        "72": "CP1250",
        "73": "CP1251",
        "74": "CP3840",
        "75": "CP3841",
        "76": "CP3843",
        "77": "CP3844",
        "78": "CP3845",
        "79": "CP3846",
        "80": "CP3847",
        "81": "CP3848",
        "82": "CP1001",
        "83": "CP2001",
        "84": "CP3001",
        "85": "CP3002",
        "86": "CP3011",
        "87": "CP3012",
        "88": "CP3021",
        "89": "CP3041"
      },
      "vendor": "Xprinter",
      "model": "XP-N160I",
      "description": ""
    },

    "RP80USE": {
      "codePages": {
        "0": "CP437",
        "1": "CP932",
        "2": "CP850",
        "3": "CP860",
        "4": "CP863",
        "5": "CP865",
        "6": "CP1251",
        "7": "CP866",
        "8": "Unknown",
        "9": "Unknown",
        "10": "Unknown",
        "15": "CP862",
        "16": "CP1252",
        "17": "CP1253",
        "18": "CP852",
        "19": "CP858",
        "20": "Unknown",
        "21": "Unknown",
        "22": "CP864",
        "23": "ISO_8859-1",
        "24": "CP737",
        "25": "CP1257",
        "26": "Unknown",
        "27": "CP720",
        "28": "CP855",
        "29": "CP857",
        "30": "CP1250",
        "31": "CP775",
        "32": "CP1254",
        "34": "CP1256",
        "35": "CP1258",
        "36": "ISO_8859-2",
        "37": "ISO_8859-3",
        "38": "ISO_8859-4",
        "39": "ISO_8859-5",
        "40": "ISO_8859-6",
        "41": "ISO_8859-7",
        "42": "ISO_8859-8",
        "43": "ISO_8859-9",
        "44": "ISO_8859-15",
        "45": "Unknown",
        "46": "CP856",
        "47": "CP874"
      },
      "vendor": "Rongta",
      "model": "RP80USE",
      "description": ""
    },

    "TP806L": {
      "codePages": {
        "0": "PC437",
        "1": "Katakana",
        "2": "PC850",
        "3": "PC860",
        "4": "PC863",
        "5": "PC865",
        "13": "PC857",
        "14": "PC737",
        "15": "ISO8859-7",
        "16": "WPC1252",
        "17": "PC866",
        "18": "PC852",
        "19": "PC858",
        "20": "KU42",
        "32": "PC720",
        "37": "PC864",
        "50": "WPC1256",
        "63": "ISO-8859-6"
      },
      "vendor": "HPRT",
      "model": "TP806L",
      "description": ""
    }
  }
}
''';
