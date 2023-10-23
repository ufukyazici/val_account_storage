import 'package:account_storage/account_model.dart';
import 'package:account_storage/accounts_cache.dart';
import 'package:account_storage/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late final AccountsSharedManager accountCacheManager;
  String _rank = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mailPasswordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  List<AccountModel> accounts = [];
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    initializeAndSave();
  }

  Future<void> initializeAndSave() async {
    accountCacheManager = AccountsSharedManager();
    await accountCacheManager.init();
    accounts = accountCacheManager.getAccounts() ?? [];
    setState(() {});
  }

  void resetControllers() {
    setState(() {
      _usernameController.text = "";
      _passwordController.text = "";
      _mailController.text = "";
      _mailPasswordController.text = "";
      _dobController.text = "";
      _rank = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accounts Storage"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              "assets/png/lock.png",
              color: Colors.white,
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _key,
                      autovalidateMode: AutovalidateMode.always,
                      child: ListView(
                        children: [
                          TextFormField(
                              validator: FormFieldValidator().isNotEmpty,
                              controller: _usernameController,
                              decoration: InputDecoration(labelText: LanguageItems.username)),
                          TextFormField(
                              validator: FormFieldValidator().isNotEmpty,
                              controller: _passwordController,
                              decoration: InputDecoration(labelText: LanguageItems.password)),
                          TextFormField(
                              validator: FormFieldValidator().isNotEmpty,
                              controller: _mailController,
                              decoration: InputDecoration(labelText: LanguageItems.mail)),
                          TextFormField(
                              validator: FormFieldValidator().isNotEmpty,
                              controller: _mailPasswordController,
                              decoration: InputDecoration(labelText: LanguageItems.mailPassword)),
                          TextFormField(
                              validator: FormFieldValidator().isNotEmpty,
                              controller: _dobController,
                              decoration: InputDecoration(labelText: LanguageItems.dob)),
                          DropdownButtonFormField(
                            hint: const Text("Rank"),
                            validator: FormFieldValidator().isNotEmpty,
                            items: [
                              DropdownMenuItem(value: "Diamond-1", child: Text(LanguageItems.diamond1)),
                              DropdownMenuItem(value: "Diamond-2", child: Text(LanguageItems.diamond2)),
                              DropdownMenuItem(value: "Diamond-3", child: Text(LanguageItems.diamond3)),
                              DropdownMenuItem(value: "Ascendant-1", child: Text(LanguageItems.ascendant1)),
                              DropdownMenuItem(value: "Ascendant-2", child: Text(LanguageItems.ascendant2)),
                              DropdownMenuItem(value: "Ascendant-3", child: Text(LanguageItems.ascendant3)),
                              DropdownMenuItem(value: "Immortal-1", child: Text(LanguageItems.immortal1)),
                              DropdownMenuItem(value: "Immortal-2", child: Text(LanguageItems.immortal2)),
                              DropdownMenuItem(value: "Immortal-3", child: Text(LanguageItems.immortal3)),
                              DropdownMenuItem(value: "Radiant", child: Text(LanguageItems.radiant)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _rank = value ?? "";
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_key.currentState?.validate() ?? false) {
                                    accounts.add(AccountModel(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        mail: _mailController.text,
                                        mailPassword: _mailPasswordController.text,
                                        dob: _dobController.text,
                                        rank: _rank));
                                    accountCacheManager.saveAccounts(accounts);
                                    resetControllers();
                                    Navigator.of(context).pop();
                                  }
                                },
                                icon: const Icon(Icons.save_outlined),
                                label: Text(LanguageItems.save)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            label: Text(LanguageItems.addAccount)),
      ],
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       showModalBottomSheet(
      //         context: context,
      //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      //         builder: (context) {
      //           return Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Form(
      //               key: _key,
      //               autovalidateMode: AutovalidateMode.always,
      //               child: ListView(
      //                 children: [
      //                   TextFormField(
      //                       validator: FormFieldValidator().isNotEmpty,
      //                       controller: _usernameController,
      //                       decoration: InputDecoration(labelText: LanguageItems.username)),
      //                   TextFormField(
      //                       validator: FormFieldValidator().isNotEmpty,
      //                       controller: _passwordController,
      //                       decoration: InputDecoration(labelText: LanguageItems.password)),
      //                   TextFormField(
      //                       validator: FormFieldValidator().isNotEmpty,
      //                       controller: _mailController,
      //                       decoration: InputDecoration(labelText: LanguageItems.mail)),
      //                   TextFormField(
      //                       validator: FormFieldValidator().isNotEmpty,
      //                       controller: _mailPasswordController,
      //                       decoration: InputDecoration(labelText: LanguageItems.mailPassword)),
      //                   TextFormField(
      //                       validator: FormFieldValidator().isNotEmpty,
      //                       controller: _dobController,
      //                       decoration: InputDecoration(labelText: LanguageItems.dob)),
      //                   DropdownButtonFormField(
      //                     hint: const Text("Rank"),
      //                     validator: FormFieldValidator().isNotEmpty,
      //                     items: [
      //                       DropdownMenuItem(value: "Diamond-1", child: Text(LanguageItems.diamond1)),
      //                       DropdownMenuItem(value: "Diamond-2", child: Text(LanguageItems.diamond2)),
      //                       DropdownMenuItem(value: "Diamond-3", child: Text(LanguageItems.diamond3)),
      //                       DropdownMenuItem(value: "Ascendant-1", child: Text(LanguageItems.ascendant1)),
      //                       DropdownMenuItem(value: "Ascendant-2", child: Text(LanguageItems.ascendant2)),
      //                       DropdownMenuItem(value: "Ascendant-3", child: Text(LanguageItems.ascendant3)),
      //                       DropdownMenuItem(value: "Immortal-1", child: Text(LanguageItems.immortal1)),
      //                       DropdownMenuItem(value: "Immortal-2", child: Text(LanguageItems.immortal2)),
      //                       DropdownMenuItem(value: "Immortal-3", child: Text(LanguageItems.immortal3)),
      //                       DropdownMenuItem(value: "Radiant", child: Text(LanguageItems.radiant)),
      //                     ],
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _rank = value ?? "";
      //                       });
      //                     },
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 22.0),
      //                     child: ElevatedButton.icon(
      //                         onPressed: () {
      //                           if (_key.currentState?.validate() ?? false) {
      //                             accounts.add(AccountModel(
      //                                 username: _usernameController.text,
      //                                 password: _passwordController.text,
      //                                 mail: _mailController.text,
      //                                 mailPassword: _mailPasswordController.text,
      //                                 dob: _dobController.text,
      //                                 rank: _rank));
      //                             accountCacheManager.saveAccounts(accounts);
      //                             resetControllers();
      //                             Navigator.of(context).pop();
      //                           }
      //                         },
      //                         icon: const Icon(Icons.save_outlined),
      //                         label: Text(LanguageItems.save)),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     },
      //     label: Text(LanguageItems.addAccount)),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: Colors.black12,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListTile(
                leading: Image.asset("assets/png/${accounts[index].rank}.png"),
                title: Text("${accounts[index].username}"),
                subtitle: Text("${accounts[index].mail}"),
                trailing: Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Username : ${accounts[index].username} | Password : ${accounts[index].password} | Mail : ${accounts[index].mail} | Mail Password : ${accounts[index].mailPassword} | Rank : ${accounts[index].rank} | Date of Birth : ${accounts[index].dob}"));
                        },
                        icon: const Icon(Icons.copy_outlined)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          accounts.removeAt(index);
                          accountCacheManager.saveAccounts(accounts);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete_outlined)),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false) ? null : ValidatorMessage()._notEmpty;
  }
}

class ValidatorMessage {
  final String _notEmpty = "This area cannot be null!";
}
