import { Environment, Store, RecordSource } from "relay-runtime";
import {
  RelayNetworkLayer,
  urlMiddleware,
  retryMiddleware,
  errorMiddleware,
  loggerMiddleware,
  type Variables,
} from "react-relay-network-modern/es";

export const makeEnvironment = () => {
  return new Environment({
    store: new Store(new RecordSource(), {
      gcReleaseBufferSize: 10,
    }),
    network: new RelayNetworkLayer(
      [
        urlMiddleware({
          url: `${process.env.NEXT_PUBLIC_API_URL}/graphql`,
        }),
        retryMiddleware(),
        process.env.NODE_ENV !== "development" ? undefined : errorMiddleware(),
        process.env.NODE_ENV !== "development"
          ? undefined
          : loggerMiddleware({
              logger: (name: string, req: { variables: Variables }) => {
                console.info(
                  `[RELAY] ${name}\n\t* variables: ${JSON.stringify(
                    req.variables
                  )}`
                );
              },
            }),
      ].filter(
        (middleware): middleware is NonNullable<typeof middleware> =>
          !!middleware
      )
    ),
  });
};
