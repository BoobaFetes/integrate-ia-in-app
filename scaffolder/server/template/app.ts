import cookieParser from "cookie-parser";
import express from "express";
import logger from "morgan";
import path from "path";
import { router } from "./routes";

var app = express();

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.use("/api", router);

const port = process.env.port || 3001;
app.listen(port, function () {
  console.log(`App is listening on port http://localhost:${port} !`);
});

export default app;
