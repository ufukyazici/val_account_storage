import 'dart:convert';

import 'package:account_storage/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AccountKeys { accounts }

class AccountsSharedManager {
  SharedPreferences? preferences;

  AccountsSharedManager();
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  List<String>? getStringItems(AccountKeys key) {
    return preferences?.getStringList(key.name);
  }

  Future<void> saveStrings(AccountKeys key, List<String> value) async {
    await preferences?.setStringList(key.name, value);
  }

  Future<void> saveAccounts(List<AccountModel> account) async {
    final acc = account.map((e) => jsonEncode(e)).toList();
    await saveStrings(AccountKeys.accounts, acc);
  }

  List<AccountModel>? getAccounts() {
    final itemsString = getStringItems(AccountKeys.accounts);
    if (itemsString?.isNotEmpty ?? false) {
      return itemsString!.map((e) {
        final json = jsonDecode(e);
        if (json is Map<String, dynamic>) {
          return AccountModel.fromJson(json);
        }
        return AccountModel(
            username: "",
            dob: "",
            password: "",
            mail: "",
            mailPassword: "",
            rank: "");
      }).toList();
    }
    return null;
  }
}
