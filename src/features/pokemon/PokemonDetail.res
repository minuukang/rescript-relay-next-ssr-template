module Fragment = %relay(`
  fragment PokemonDetail_Fragment on Query
  @argumentDefinitions(pokemonEnum: { type: "PokemonEnum!" }) {
    getPokemon(pokemon: $pokemonEnum) {
      key
      sprite
      baseSpecies
      forme
      species
      types {
        name
      }
    }
  }
`)

@react.component
let make = (~fragmentRefs) => {
  let {getPokemon: pokemon} = Fragment.use(fragmentRefs)
  <article>
    <h1>
      {pokemon.baseSpecies->Belt.Option.getWithDefault(pokemon.species)->React.string}
      {pokemon.forme->Belt.Option.mapWithDefault(React.null, forme =>
        <small> {`(${forme})`->React.string} </small>
      )}
    </h1>
    <img src={pokemon.sprite} alt="" />
    <h2> {`Types`->React.string} </h2>
    <ul>
      {pokemon.types
      ->Belt.Array.map(type_ => <li key={type_.name}> {type_.name->React.string} </li>)
      ->React.array}
    </ul>
  </article>
}
