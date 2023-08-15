module Fragment = %relay(`
  fragment PokemonItem_Fragment on Pokemon {
    id
    name
  }
`)

@module("./PokemonItem.module.css")
external styles: {..} = "default"

@react.component
let make = (~fragmentRefs) => {
  let pokemon = Fragment.use(fragmentRefs)
  <Next.Link href={`/pokemon/${pokemon.id}`}>
    <figure className={styles["wrapper"]}>
      <img src={PokemonUtils.makeSpriteImage(pokemon.name)} alt="" />
      <figcaption> {`No.${pokemon.id}: ${pokemon.name}`->React.string} </figcaption>
    </figure>
  </Next.Link>
}
