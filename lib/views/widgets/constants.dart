//colors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const backgroundcolor = Colors.black;
var buttoncolor = Colors.red[400];
const bordercolor = Colors.grey;

//firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorge = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

const pages = [
  Text('Home'),
  Text('Search'),
  Text('Add'),
  Text('Message'),
  Text('Profile'),
];
