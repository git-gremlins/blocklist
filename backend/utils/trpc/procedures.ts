import { t } from "./";
import { isAuthed } from "./middleware";

export const publicProcedure = t.procedure;
export const userProcedure = publicProcedure.use(isAuthed);
