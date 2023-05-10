import { initTRPC } from "@trpc/server";
import type { Context } from "./context";

export const t = initTRPC.context<Context>().create();
export const middleware = t.middleware;
export const router = t.router;
export { publicProcedure, userProcedure } from "./procedures";
export { createContext } from "./context";

export default t;
