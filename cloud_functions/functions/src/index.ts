import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
//import { Change } from 'firebase-functions';


admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
 //export const helloWorld = functions.https.onRequest((request, response) => {
 //response.send("Hello from Firebase!");
 //});
 export const sendToDevice = functions.firestore
  .document('users/{userId}')
  .onUpdate(async Change => {

    const newValue = Change.after.data();
    const previousValue = Change.before.data();
    console.log('value: ' +Change.before.id);

    if(newValue.etat=="infecte" && (previousValue.etat=="ensuivi" || previousValue.etat=="normal") ) {

    const querySnapshot = await db
      .collection('users')
      .doc(Change.before.id)
      .collection('met_with')
      .get();
    
    //console.log('uid: ' +newValue.uid);
    const tokens = querySnapshot.docs.map(snap => snap.data().token);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'Possilbilité d\'etre infecté',
        body: 'Bonjour !! '+newValue.nom +' '+ newValue.prenom +' que vous avez rencontré été infecté par le virus !! Essayez de passer en quarantaine le plutot possible et de faire un teste!!',
        //icon: FontAwesomeIcons,
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
    } else {
        return null;
    }
  });
