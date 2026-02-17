import jwt from "jsonwebtoken";
import { pool } from "../../dbconnection.js";
import bcrypt from "bcrypt";

const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!(username && password)) {
      return res.status(400).send("All inputs are required");
    }

    const result = await pool.query(
      "SELECT * FROM users WHERE username = $1",
      [username]
    );

    const user = result.rows[0]; 

    if (user && (await bcrypt.compare(password, user.password))) {
      const token = jwt.sign(
        {
          user_id: user.id,
          username,
        },
        process.env.JWT_SECRET || "test",
        { expiresIn: "24h" }
      );

      return res.status(200).json({ ...user, token });
    }

    return res.status(401).send("Unauthorized login");

  } catch (e) {

    console.log("Error in login:", e);
    return res.status(500).send("Internal server error");
  }
};

export { login };