import 'package:flutter/material.dart';
import 'package:task/constant/drawer.dart';
import 'package:task/database/database_helper.dart';
import 'package:task/model/contact.dart';

class Home extends StatefulWidget {
  String id;
  Home(this.id);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Contact _contact = Contact();
  DatabaseHelper? _dbHelper;
  List<Contact> _contacts = [];
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();
  final _ctrlMobile = TextEditingController();
  final _ctrlAddress = TextEditingController();
  @override
  void initState() {
    //   getuserid() async {
    //   Database? db = await _dbHelper!.database;
    //   List<Map> x = await db!.rawQuery(
    //       "select max(id) from User");
    //   for (var item in x) {
    //     item['name'];
    //     item['mobile'];
    //     item['address'];
    //     item['birthday'];
    //   }
    // }
    super.initState();

    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    _contact.userid = widget.id as String?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4DA7AA),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _form(),
              TextButton(
                onPressed: () => _list(),
                child: Text('Show All Contacts'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ctrlName,
                enableSuggestions: true,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                autofillHints: [AutofillHints.name],
                keyboardType: TextInputType.text,
                onSaved: (val) => setState(() => _contact.name = val),
                validator: (val) =>
                    (val!.length == 0 ? 'This Field Is Required' : null),
              ),
              TextFormField(
                controller: _ctrlMobile,
                enableSuggestions: true,
                decoration: InputDecoration(labelText: 'Mobile'),
                autofillHints: [AutofillHints.telephoneNumberNational],
                keyboardType: TextInputType.number,
                onSaved: (val) => setState(() => _contact.phone = val),
                // validator: (val) => (val!.length < 10 || val.length > 10
                //     ? 'Phone Number must be 10 character'
                //     : null),
              ),
              TextFormField(
                controller: _ctrlAddress,
                enableSuggestions: true,
                decoration: InputDecoration(labelText: 'Address'),
                autofillHints: [AutofillHints.postalAddress],
                keyboardType: TextInputType.text,
                onSaved: (val) => setState(() => _contact.address = val),
                validator: (val) =>
                    (val!.length == 0 ? 'This Field Is Required' : null),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => _onSubmit(),
                        child: Text('Submit'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
  _list() async {
    List<Contact> t = await _dbHelper!.fetchContacts(widget.id);
    setState(() {
      _contacts = t;
    });
    showModalBottomSheet(
      context: context,
      builder: (context) {
        if (_contacts.length == 0)
          return Expanded(
            child: Card(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 50),
                child: ListTile(
                  leading: Icon(Icons.contact_mail),
                  title: Text("Empty"),
                )),
          );
        else
          return Column(children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'Tap to update contact',
              style: TextStyle(fontSize: 15),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                          title: Text(
                            _contacts[index].name!.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(_contacts[index].phone.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(_contacts[index].address.toString()),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_sweep),
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text('Delete Contact ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _dbHelper!.deleteContact(
                                                int.parse(_contacts[index]
                                                    .id
                                                    .toString()));
                                            setState(() {
                                              Navigator.pop(context);
                                              _resetForm();
                                              _refreshContactList();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    );
                                  })),
                          onTap: () {
                            _resetForm();
                            setState(() {
                              _contact = _contacts[index];
                              _ctrlName.text = _contacts[index].name!;
                              _ctrlMobile.text = _contacts[index].phone!;
                              _ctrlAddress.text = _contacts[index].address!;
                            });
                          },
                        ),
                        Divider(
                          height: 5.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ]);
      },
    );
  }

  _refreshContactList() async {
    List<Contact> x = await _dbHelper!.fetchContacts(widget.id);
    setState(() {
      _contacts = x;
    });
  }

  _resetForm() {
    setState(() {
      _formKey.currentState!.reset();
      _ctrlName.clear();
      _ctrlMobile.clear();
      _ctrlAddress.clear();
      _contact.id = null;
    });
  }

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (_contact.id == null) {
        // _contact.userid=
        await _dbHelper!.insertContact(_contact);
      } else {
        await _dbHelper!.updateContact(_contact);
      }
      _refreshContactList();
      _resetForm();
    }
  }
}
