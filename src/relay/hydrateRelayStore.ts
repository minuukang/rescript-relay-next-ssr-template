import { GetServerSidePropsContext } from "next";
import RelayModernEnvironment from "relay-runtime/lib/store/RelayModernEnvironment";
import { makeEnvironment } from "./environment";

const storeName = "__relayStore__";

export async function hydrateRelayStore(
  context: GetServerSidePropsContext,
  callback: (env: RelayModernEnvironment) => Promise<unknown>
) {
  const environment: RelayModernEnvironment = makeEnvironment();
  const result = await callback(environment);
  return {
    ...(typeof result === "object" ? result : {}),
    [storeName]: environment.getStore().getSource().toJSON(),
  };
}
