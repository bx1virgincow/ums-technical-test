import express, { json } from "express";
const expressInstance = express();
import authModule from "./routes/authroute.js";
const { expRoute } = authModule;
import cors from 'cors';

expressInstance.use(cors())
expressInstance.use(json());
expressInstance.use("/auth", expRoute);

expressInstance.get("/", (req, res) => {
  console.log("run last!");
  return res.status(200).json({ message: "ok" });
});

expressInstance.listen(1234, console.log("listening on port 1234"));
