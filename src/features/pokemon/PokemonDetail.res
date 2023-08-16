module Fragment = %relay(`
  fragment PokemonDetail_Fragment on Pokemon {
    id
    name
    types
    weight {
      minimum
      maximum
    }
    height {
      minimum
      maximum
    }
    evolutions {
      id
      ...PokemonItem_Fragment
    }
  }
`)

@module("./PokemonDetail.module.css")
external styles: {..} = "default"

@react.component
let make = (~fragmentRefs) => {
  let pokemon = Fragment.use(fragmentRefs)
  <article>
    <h1> {pokemon.name->React.string} </h1>
    <img src={PokemonUtils.makeSpriteImage(pokemon.name)} alt="" width="168" />
    <ul>
      <li> {`weight: ${pokemon.weight.minimum} ~ ${pokemon.weight.maximum}`->React.string} </li>
      <li> {`height: ${pokemon.height.minimum} ~ ${pokemon.height.maximum}`->React.string} </li>
    </ul>
    <h2> {`Types`->React.string} </h2>
    <ul>
      {pokemon.types
      ->Belt.Array.map(type_ =>
        <li key={type_->Fragment.pokemonType_toString}>
          <img
            src={PokemonUtils.makeTypeImage(type_)}
            width="50"
            alt={switch type_ {
            | #Grass => `풀`
            | #Poison => `독`
            | #Fire => `불꽃`
            | #Flying => `비행`
            | #Water => `물`
            | #Bug => `벌레`
            | #Normal => `노멀`
            | #Electric => `전기`
            | #Ground => `땅`
            | #Fairy => `페어리`
            | #Fighting => `격투`
            | #Psychic => `에스퍼`
            | #Rock => `바위`
            | #Steel => `강철`
            | #Ice => `얼음`
            | #Ghost => `고스트`
            | #Dragon => `드래곤`
            | #Dark => `악`
            }}
          />
        </li>
      )
      ->React.array}
    </ul>
    {switch pokemon.evolutions {
    | Some([]) => React.null
    | Some(evolutions) =>
      <>
        <h2> {`Evolutions`->React.string} </h2>
        <ul className={styles["list"]}>
          {evolutions
          ->Belt.Array.map(pokemon =>
            <li key={pokemon.id}>
              <PokemonItem fragmentRefs=pokemon.fragmentRefs />
            </li>
          )
          ->React.array}
        </ul>
      </>
    | None => React.null
    }}
  </article>
}
