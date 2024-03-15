//
//  Constants.swift
//  Twitter
//
//  Created by Dan Hozan on 13.03.2024.
//

import Firebase
import SwiftUI


let twitterBlue = Color(red: 47/255, green: 161/255, blue: 243/255)

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_TWEETS = Firestore.firestore().collection("tweets")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
