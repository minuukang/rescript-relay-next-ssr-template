module Fragment = %relay(`
  fragment PokemonFeed_Fragment on Query {
    getAllPokemon(offset: 87, take: 100) {
      key
      ...PokemonItem_Fragment
    }
  }
`)

@module("./PokemonFeed.module.css")
external styles: {..} = "default"

@react.component
let make = (~fragmentRefs) => {
  let {getAllPokemon} = Fragment.use(fragmentRefs)
  <div>
    <h1> {`Pokemons`->React.string} </h1>
    <ul className={styles["list"]}>
      {getAllPokemon
      ->Belt.Array.map(pokemon =>
        <li key={pokemon.key->Fragment.pokemonEnum_toString} className={styles["item"]}>
          <PokemonItem fragmentRefs=pokemon.fragmentRefs />
        </li>
      )
      ->React.array}
    </ul>
  </div>
}
