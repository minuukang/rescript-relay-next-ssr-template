const bsconfig = require("./bsconfig.json");

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  reactStrictMode: true,
  swcMinify: true,
  pageExtensions: ["tsx", "ts", "bs.js"],
  experimental: {
    scrollRestoration: true,
    transpilePackages: ["rescript"]
      .concat(
        bsconfig["bs-dependencies"]?.filter(
          (dep) => !bsconfig["pinned-dependencies"]?.includes(dep)
        )
      )
      .concat(["react-relay-network-modern"]),
  },
};

module.exports = nextConfig;
