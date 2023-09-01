// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { Firestore, getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC0qjy59D0-uhRYSibbeJj65qbZzdU4bWM",
  authDomain: "protofac-4093c.firebaseapp.com",
  projectId: "protofac-4093c",
  storageBucket: "protofac-4093c.appspot.com",
  messagingSenderId: "665287090208",
  appId: "1:665287090208:web:f89bcbb31d6ba3ee435c45",
  measurementId: "G-1P50HR9THS"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const db = getFirestore(app) as Firestore;
