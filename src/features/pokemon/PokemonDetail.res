module Fragment = %relay(`
  fragment PokemonDetail_Fragment on Pokemon {
    id
    name
    types
  }
`)

@react.component
let make = (~fragmentRefs) => {
  let pokemon = Fragment.use(fragmentRefs)
  <article>
    <h1> {pokemon.name->React.string} </h1>
    <img src={PokemonUtils.makeSpriteImage(pokemon.name)} alt="" />
    <h2> {`Types`->React.string} </h2>
    <ul>
      {pokemon.types
      ->Belt.Array.map(type_ =>
        <li key={type_->Fragment.pokemonType_toString}>
          {switch type_ {
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
          }->React.string}
        </li>
      )
      ->React.array}
    </ul>
  </article>
}
