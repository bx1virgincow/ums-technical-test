import { pool } from "../dbconnection.js"; 
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const migrate = async () => {
  try {
    const sql = fs.readFileSync(path.join(__dirname, "init.sql"), "utf-8");
    await pool.query(sql);
    console.log("Migration complete");
  } catch (e) {
    console.error("Migration failed:", e);
  } finally {
    await pool.end();
  }
};

migrate();