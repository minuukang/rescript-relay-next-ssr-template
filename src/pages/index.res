module Query = %relay(`
  query pages_Index_Query {
    ...PokemonFeed_Fragment
  }
`)

type params

let getServerSideProps = RelayEnv.SSR.make(async (
  ~context as _: Next.GetServerSideProps.context<params>,
  ~environment,
) => {
  let _ = await Query.fetchPromised(~environment, ~variables=(), ())
  None
})

let default = () => {
  let {fragmentRefs} = Query.use(~variables=(), ())
  <PokemonFeed fragmentRefs />
}
