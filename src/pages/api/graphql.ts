// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const response = await fetch(
    `https://trygql.formidable.dev/graphql/basic-pokedex`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(req.body),
    }
  );
  res.status(response.status);
  if (response.ok) {
    const json = await response.json();
    res.send(json);
  } else {
    console.error(await response.text());
    res.send(await response.text());
  }
}
