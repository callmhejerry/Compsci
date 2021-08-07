import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const fcm = admin.messaging();
const database = admin.firestore();

export const sendToAnnouncements = functions.firestore
    .document("Annocements/{AnnocementId}")
    .onCreate(async (snapshot) => {
      const announcements = snapshot.data();
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "Announcement!",
          body: announcements.Description,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });


export const sendToAssignments = functions.firestore
    .document("Assignments/{AssignmentsId}")
    .onCreate(async (snapshot) => {
      const assignments = snapshot.data();
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New Assignment!",
          body: assignments.course,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });


export const sendToMonday = functions.firestore
    .document("Monday/{MondayId}")
    .onCreate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the monday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToUpdateMonday = functions.firestore
    .document("Monday/{MondayId}")
    .onUpdate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "TimeTable updated!",
          body: "The monday timetable has been updated ",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();

      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToTuesday = functions.firestore
    .document("Tuesday/{TuesdayId}")
    .onCreate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the Tuesday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();

      const tokens = tokenRef.docs.map((doc) => doc.id);

      return fcm.sendToDevice(tokens, payload);
    });

export const sendToUpdateTuesday = functions.firestore
    .document("Tuesday/{TuesdayId}")
    .onUpdate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "TimeTable updated!",
          body: "The tuesday timetable has been updated ",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });


export const sendToWednesday = functions.firestore
    .document("Wednesday/{WednesdayId}")
    .onCreate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the Wednesday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToWriteWednesday = functions.firestore
    .document("Wednesday/{WednesdayId}")
    .onWrite(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the Wednesday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToUpdateWednesday = functions.firestore
    .document("Wednesday/{WednesdayId}")
    .onUpdate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "TimeTable updated!",
          body: "The wednesday timetable has been updated ",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });


export const sendToThursday = functions.firestore
    .document("Thursday/{ThursdayId}")
    .onCreate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the Thursday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToUpdateThursday = functions.firestore
    .document("Thursday/{ThursdayId}")
    .onUpdate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "TimeTable updated!",
          body: "The thursday timetable has been updated ",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();

      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });


export const sendToFriday = functions.firestore
    .document("Friday/{FridayId}")
    .onCreate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New class added!",
          body: "A new class has been added to the Friday timetable",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToUpdateFriday = functions.firestore
    .document("Friday/{FridayId}")
    .onUpdate(async () => {
      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "TimeTable updated!",
          body: "The Friday timetable has been updated ",
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      const tokenRef = await database
          .collection("Users")
          .doc("user tokens")
          .collection("tokens")
          .get();
      const tokens = tokenRef.docs.map((doc) => doc.id);
      return fcm.sendToDevice(tokens, payload);
    });

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
