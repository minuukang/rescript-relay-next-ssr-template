@module("./environment.ts")
external makeEnvironment: unit => RescriptRelay.Environment.t = "makeEnvironment"

@module("./hydrateRelayStore.ts")
external hydrateRelayStore: (
  Next.GetServerSideProps.context<'a>,
  RescriptRelay.Environment.t => promise<option<{..}>>,
) => promise<{..}> = "hydrateRelayStore"

module SSR = {
  let make = (
    handler: (
      ~context: Next.GetServerSideProps.context<'params>,
      ~environment: RescriptRelay.Environment.t,
    ) => promise<option<Next.GetServerSideProps.result>>,
  ) => {
    context => Next.GetServerSideProps.make(async context => {
        let result = ref(None)
        let propsResult = await hydrateRelayStore(context, async environment => {
          result.contents = await handler(~context, ~environment)
          None
        })
        switch result.contents {
        | Some(Next.GetServerSideProps.Props(props')) =>
          Next.GetServerSideProps.Props(Js.Obj.assign(propsResult, props'))
        | Some(other) => other
        | None => Next.GetServerSideProps.Props(propsResult)
        }
      }, context)
  }
}
