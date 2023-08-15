module Query = %relay(`
  query PokemonId_Page_Query($pokemonId: ID!) {
    pokemon(id: $pokemonId) {
      ...PokemonDetail_Fragment
    }
  }
`)

type params = {pokemonId: string}

let getServerSideProps = RelayEnv.SSR.make(async (
  ~context: Next.GetServerSideProps.context<params>,
  ~environment,
) => {
  let _ = await Query.fetchPromised(
    ~environment,
    ~variables={
      pokemonId: context.params.pokemonId,
    },
    (),
  )
  None
})

let default = () => {
  let router = Next.Router.useRouter()
  let pokemonId = router.query->Js.Dict.get("pokemonId")->Belt.Option.getExn
  let {pokemon} = Query.use(~variables={pokemonId: pokemonId}, ())
  <PokemonDetail fragmentRefs={(pokemon->Belt.Option.getExn).fragmentRefs} />
}
