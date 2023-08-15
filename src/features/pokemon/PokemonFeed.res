module Fragment = %relay(`
  fragment PokemonFeed_Fragment on Query {
    pokemons(limit: 1000) {
      id
      ...PokemonItem_Fragment
    }
  }
`)

@module("./PokemonFeed.module.css")
external styles: {..} = "default"

@react.component
let make = (~fragmentRefs) => {
  let {pokemons} = Fragment.use(fragmentRefs)
  <div>
    <h1> {`Pokemons`->React.string} </h1>
    <ul className={styles["list"]}>
      {pokemons
      ->Belt.Option.getWithDefault([])
      ->Belt.Array.map(pokemon =>
        <li key={pokemon.id}>
          <PokemonItem fragmentRefs=pokemon.fragmentRefs />
        </li>
      )
      ->React.array}
    </ul>
  </div>
}
