import express from "express";
import cors from "cors";
import { createExpressMiddleware } from "@trpc/server/adapters/express";
import { appRouter } from "./routers";

const app = express();
app.use(cors({ origin: "*" }));
app.use("/", createExpressMiddleware({ router: appRouter }));

//j fldks fldjs lfjds lj
const port = 4000;
app.listen(port);
console.log(`Server running on port ${port}...`);
