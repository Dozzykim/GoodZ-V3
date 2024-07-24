import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:intl/intl.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwChkController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 성별 변수 선언
  String _gender = "여자";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: ListView(
        children: [
          const Text(
            "회원가입",
            style: TextStyle(fontSize: 30.0),
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _idController,
                  decoration: const InputDecoration(labelText: "아이디"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "아이디를 입력하세요.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pwController,
                  decoration: const InputDecoration(labelText: "비밀번호"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "비밀번호를 입력하세요.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pwChkController,
                  decoration: const InputDecoration(labelText: "비밀번호 확인"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "비밀번호 확인을 입력하세요.";
                    }
                    if (value != _pwController.text) {
                      return "비밀번호가 일치하지 않습니다.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text("성별"),
                    Radio(
                        value: "남자",
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "남자";
                        });
                      },
                      child: const Text("남자"),
                    ),
                    Radio(
                        value: "여자",
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "여자";
                        });
                      },
                      child: const Text("여자"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: _birthController,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "생년월일",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              picker.DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(),
                                  theme: const picker.DatePickerTheme(
                                      headerColor: Colors.orange,
                                      backgroundColor: Colors.blue,
                                      itemStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)), onConfirm: (date) {
                                var dateFormat =
                                    DateFormat('yyyy/MM/dd').format(date);
                                _birthController.text = dateFormat;
                              },
                                  currentTime: DateTime.now(),
                                  locale: picker.LocaleType.ko);
                            },
                            child: const Icon(Icons.calendar_month),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "생년월일을 입력하세요.";
                        }
                        return null;
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("아이디 : ${_idController.text}");
                      print("비밀번호 : ${_pwController.text}");
                      print("비밀번호 확인 : ${_pwChkController.text}");
                      print("성별 : ${_gender}");
                      print("생년월일 : ${_birthController.text}");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minimumSize: const Size(double.infinity, 40.0)),
                  child: const Text("회원가입"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
