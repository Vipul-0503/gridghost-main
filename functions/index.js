const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Initialize Admin SDK (runs once)
admin.initializeApp();

/**
 * Secure role assignment function
 * Only admins can assign roles
 */
exports.setUserRole = onRequest(async (req, res) => {
  try {
    // 🔐 Step 1: Check Authorization header
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).send("Unauthorized: Missing token");
    }

    // 🔐 Step 2: Verify Firebase ID Token
    const idToken = authHeader.split("Bearer ")[1];
    const decodedToken = await admin.auth().verifyIdToken(idToken);

    // 🔐 Step 3: Only admins can assign roles
    if (decodedToken.role !== "admin") {
      return res.status(403).send("Permission denied: Admins only");
    }

    // 🔐 Step 4: Validate input
    const {uid, role} = req.body;

    const allowedRoles = ["citizen", "verified_lineman", "admin"];
    if (!allowedRoles.includes(role)) {
      return res.status(400).send("Invalid role");
    }

    // 🔐 Step 5: Assign custom claim
    await admin.auth().setCustomUserClaims(uid, {role});

    return res.status(200).json({
      success: true,
      message: `Role '${role}' assigned to user ${uid}`,
    });
  } catch (error) {
    logger.error(error);
    return res.status(500).send("Internal server error");
  }
});
