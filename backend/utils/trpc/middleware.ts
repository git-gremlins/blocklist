import { TRPCError } from "@trpc/server";
import { middleware } from "./index";

export const isAuthed = middleware(async ({ ctx, next }) => {
  if (!ctx.authenticationStatus) {
    throw new TRPCError({
      code: "UNAUTHORIZED",
    });
  }
  return next({
    ctx,
  });
});
