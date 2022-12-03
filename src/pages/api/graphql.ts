// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";

export default async function handler(
  _req: NextApiRequest,
  res: NextApiResponse
) {
  const response = await fetch(`https://graphqlpokemon.favware.tech/v7`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  });
  res.status(response.status);
  res.send(await response.json());
}
