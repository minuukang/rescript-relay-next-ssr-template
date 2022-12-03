import React, { useMemo, useRef } from "react";
import type { AppProps } from "next/app";
import { RelayEnvironmentProvider } from "react-relay";
import { commitLocalUpdate, RecordSource } from "relay-runtime";
import { makeEnvironment } from "../relay/environment";

import "../../styles/globals.css";

interface PageProps {
  __relayStore__?: Record<string, Record<string, string>>;
}

function App({ Component, pageProps, router }: AppProps) {
  const { __relayStore__ } = pageProps as PageProps;
  const environment = useMemo(() => makeEnvironment(), []);
  const relayStoreRef = useRef<Record<string, PageProps["__relayStore__"]>>({});
  useMemo(() => {
    const key = (router as unknown as { _key: string })._key;
    if (!relayStoreRef.current[key]) {
      relayStoreRef.current[key] = __relayStore__;
      if (__relayStore__) {
        const recordStore = new RecordSource(__relayStore__);
        commitLocalUpdate(environment, (store) => {
          recordStore.getRecordIDs().forEach((dataID) => {
            store
              .get(dataID)
              ?.getLinkedRecords("edges")
              ?.forEach((edge) => {
                store.delete(edge.getDataID());
              });
          });
        });
        environment.getStore().publish(recordStore);
      }
    }
  }, [__relayStore__, environment, router]);

  return (
    <RelayEnvironmentProvider environment={environment}>
      <Component {...pageProps} />
    </RelayEnvironmentProvider>
  );
}

export default App;
