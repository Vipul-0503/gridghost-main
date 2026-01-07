const admin = require("firebase-admin");
const fs = require("fs");
const csv = require("csv-parser");

admin.initializeApp();
const db = admin.firestore();

const CSV_PATH = "./data/theft_hotspots.csv";

async function uploadHotspots() {
  const batch = db.batch();
  let count = 0;

  fs.createReadStream(CSV_PATH)
    .pipe(csv())
    .on("data", (row) => {
      const ref = db.collection("theft_hotspots").doc();

      batch.set(ref, {
        latitude: Number(row.latitude),
        longitude: Number(row.longitude),
        risk_score: Number(row.risk_score),
        city: "Jaipur",
        source: "earth_engine",
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });

      count++;
    })
    .on("end", async () => {
      await batch.commit();
      console.log(`✅ Uploaded ${count} hotspot records`);
      process.exit(0);
    });
}

uploadHotspots().catch(console.error);
