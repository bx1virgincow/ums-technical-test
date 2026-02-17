
import jwt from "jsonwebtoken";
import { pool } from "../../dbconnection.js";
import { hash } from "bcrypt";

const register = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    if (!(username && email && password)) {
      return res.status(400).send("All inputs are required");
    }

    // Check if user already exists
    const existing = await pool.query(
      "SELECT id FROM users WHERE username = $1 OR email = $2",
      [username, email]
    );

    if (existing.rows.length > 0) {
      return res.status(409).send("User already exists");
    }

    const hashedPassword = await hash(password, 10);

    // RETURNING * gives you back the inserted row, like Mongo's save()
    const result = await pool.query(
      `INSERT INTO users (username, email, password)
       VALUES ($1, $2, $3)
       RETURNING id, username, email`,
      [username, email, hashedPassword]
    );

    const newUser = result.rows[0];

    const token = jwt.sign(
      { user_id: newUser.id, username },
      process.env.JWT_SECRET || "test",
      { expiresIn: "10m" }
    );

    return res.status(201).json({ ...newUser, token });

  } catch (e) {
    console.log(e);
    return res.status(500).send("Internal server error");
  }
};

export default { register };