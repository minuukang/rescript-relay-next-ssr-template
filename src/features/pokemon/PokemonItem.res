module Fragment = %relay(`
  fragment PokemonItem_Fragment on Pokemon {
    key
    sprite
    num
    species
    forme
    baseSpecies
  }
`)

@module("./PokemonItem.module.css")
external styles: {..} = "default"

@react.component
let make = (~fragmentRefs) => {
  let pokemon = Fragment.use(fragmentRefs)
  <Next.Link href={`/pokemon/${pokemon.key->Fragment.pokemonEnum_toString}`}>
    <figure className={styles["wrapper"]}>
      <img src={pokemon.sprite} alt="" />
      <figcaption>
        {`No.${pokemon.num->Belt.Int.toString}: ${pokemon.baseSpecies->Belt.Option.getWithDefault(
            pokemon.species,
          )}${pokemon.forme->Belt.Option.mapWithDefault("", forme => ` (${forme})`)}`->React.string}
      </figcaption>
    </figure>
  </Next.Link>
}
