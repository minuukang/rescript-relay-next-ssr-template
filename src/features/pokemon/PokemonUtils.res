let makeSpriteImage = name => {
  let name = name->Js.String2.toLowerCase
  let name = name->Js.String2.replaceByRe(%re("/[\s\']/g"), "")
  let name = name->Js.String2.replaceByRe(%re("/-/g"), "_")
  `https://projectpokemon.org/images/normal-sprite/${name}.gif`
}

let makeTypeImage = (type_: RelaySchemaAssets_graphql.enum_PokemonType) => {
  switch type_ {
  | #Grass => `https://archives.bulbagarden.net/media/upload/a/a8/Grass_icon_SwSh.png`
  | #Poison => `https://archives.bulbagarden.net/media/upload/8/8d/Poison_icon_SwSh.png`
  | #Fire => `https://archives.bulbagarden.net/media/upload/a/ab/Fire_icon_SwSh.png`
  | #Flying => `https://archives.bulbagarden.net/media/upload/b/b5/Flying_icon_SwSh.png`
  | #Water => `https://archives.bulbagarden.net/media/upload/8/80/Water_icon_SwSh.png`
  | #Bug => `https://archives.bulbagarden.net/media/upload/9/9c/Bug_icon_SwSh.png`
  | #Normal => `https://archives.bulbagarden.net/media/upload/9/95/Normal_icon_SwSh.png`
  | #Electric => `https://archives.bulbagarden.net/media/upload/7/7b/Electric_icon_SwSh.png`
  | #Ground => `https://archives.bulbagarden.net/media/upload/2/27/Ground_icon_SwSh.png`
  | #Fairy => `https://archives.bulbagarden.net/media/upload/c/c6/Fairy_icon_SwSh.png`
  | #Fighting => `https://archives.bulbagarden.net/media/upload/3/3b/Fighting_icon_SwSh.png`
  | #Psychic => `https://archives.bulbagarden.net/media/upload/7/73/Psychic_icon_SwSh.png`
  | #Rock => `https://archives.bulbagarden.net/media/upload/1/11/Rock_icon_SwSh.png`
  | #Steel => `https://archives.bulbagarden.net/media/upload/0/09/Steel_icon_SwSh.png`
  | #Ice => `https://archives.bulbagarden.net/media/upload/1/15/Ice_icon_SwSh.png`
  | #Ghost => `https://archives.bulbagarden.net/media/upload/0/01/Ghost_icon_SwSh.png`
  | #Dragon => `https://archives.bulbagarden.net/media/upload/7/70/Dragon_icon_SwSh.png`
  | #Dark => `https://archives.bulbagarden.net/media/upload/d/d5/Dark_icon_SwSh.png`
  }
}
