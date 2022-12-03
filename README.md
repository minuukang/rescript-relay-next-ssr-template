# Rescript + Relay + Next.js + SSR example!

* using graphql example by [GraphQL-Pokemon](https://graphql-pokemon.vercel.app/)

## Concept

1. Make feature component by using relay fragment (like [PokemonDetail.res](./src/features/pokemon/PokemonDetail.res))
2. Write page by rescript. (Warning; rescript file name should be unique by your project) ([/pages/pokemon/[pokemonEnum].res](./src/pages/pokemon/[pokemonEnum].res))
3. In page, make query and connect using feature fragments 
4. Make environment and execute query and return dehydrate store data at `getServerSideProps` (This process is configure by [RelayEnv.SSR.make](./src/relay/RelayEnv.res) function and [hydrateRelayStore.ts](./src/relay/hydrateRelayStore.ts))
5. Execute query at page renderer, pass the `fragmentRefs` to feature component
6. complete!
