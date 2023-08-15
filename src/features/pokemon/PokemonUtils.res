let makeSpriteImage = name => {
  let name = name->Js.String2.toLowerCase
  let name = name->Js.String2.replaceByRe(%re("/[\s\']/g"), "")
  let name = name->Js.String2.replaceByRe(%re("/-/g"), "_")
  `https://projectpokemon.org/images/normal-sprite/${name}.gif`
}
