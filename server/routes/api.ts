import express from "express";

export const router = express.Router();

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

router.get("/:id", function (req, res, next) {
  res.send(`get id:${req.params.id}`);
});

router.post("/:id", function (req, res, next) {
  res.send(`post id:${req.params.id} / body : ${req.body}`);
});
