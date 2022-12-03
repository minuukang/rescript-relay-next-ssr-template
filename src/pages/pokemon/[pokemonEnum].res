module Query = %relay(`
  query PokemonEnum_Page_Query($pokemonEnum: PokemonEnum!) {
    ...PokemonDetail_Fragment @arguments(pokemonEnum: $pokemonEnum)
  }
`)

type params = {pokemonEnum: string}

let getServerSideProps = RelayEnv.SSR.make(async (
  ~context: Next.GetServerSideProps.context<params>,
  ~environment,
) => {
  let _ = await Query.fetchPromised(
    ~environment,
    ~variables={
      pokemonEnum: context.params.pokemonEnum
      ->PokemonDetail_Fragment_graphql.Utils.pokemonEnum_fromString
      ->Belt.Option.getExn,
    },
    (),
  )
  None
})

let default = () => {
  let router = Next.Router.useRouter()
  let pokemonEnum =
    router.query
    ->Js.Dict.get("pokemonEnum")
    ->Belt.Option.flatMap(PokemonDetail_Fragment_graphql.Utils.pokemonEnum_fromString)
    ->Belt.Option.getExn
  let {fragmentRefs} = Query.use(~variables={pokemonEnum: pokemonEnum}, ())
  <PokemonDetail fragmentRefs />
}
