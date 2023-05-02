import { createTRPCProxyClient, httpBatchLink } from "@trpc/client";
import { AppRouter } from "../../routers";

const trpcClient = createTRPCProxyClient<AppRouter>({
  links: [
    httpBatchLink({
      url: "http://localhost:4000",
    }),
  ],
});

export default trpcClient;
