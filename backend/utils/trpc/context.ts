import { CreateExpressContextOptions } from "@trpc/server/adapters/express";
import { IncomingHttpHeaders } from "http";
import supabase from "../supabase";
import { inferAsyncReturnType } from "@trpc/server";

export const createContext = async ({
  req: { headers },
}: CreateExpressContextOptions) => {
  const { authorisation: JWTToken } = headers as IncomingHttpHeaders & {
    authorisation: string;
  };
  const {
    data: { user },
  } = await supabase.auth.getUser(JWTToken);
  return {
    authenticationStatus: user?.role,
    userId: user?.id,
  };
};

export type Context = inferAsyncReturnType<typeof createContext>;
