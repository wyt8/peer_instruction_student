import 'package:flutter/material.dart';
import 'package:peer_instruction_student/app.dart';
import 'package:peer_instruction_student/common/global.dart';

void main() {
  Global.init().then((v) => runApp(PeerInstructionStudentApp()));
}