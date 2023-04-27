import { createTRPCProxyClient, httpBatchLink } from "@trpc/client";
import { AppRouter } from "./routers";

const client = createTRPCProxyClient<AppRouter>({
  links: [
    httpBatchLink({
      url: "http://127.0.0.1:3000",
    }),
  ],
});

client.tasks.post
  .mutate({
    name: "Kamal",
    description: "Yes",
  })
  .then((temp) => {
    console.log(temp);
    return temp
  });
