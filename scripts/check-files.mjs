// Fails when fonts.css or package.json#exports point at a file that is not there,
// so a release is never tagged with a broken font URL.
import { existsSync, readFileSync, readdirSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const missing = [];

const css = readFileSync(resolve(root, "src/fonts.css"), "utf8");
for (const [, url] of css.matchAll(/url\("([^"]+)"\)/g)) {
  if (!existsSync(resolve(root, "src", url))) missing.push(`src/fonts.css -> ${url}`);
}

const { exports } = JSON.parse(readFileSync(resolve(root, "package.json"), "utf8"));
for (const [key, target] of Object.entries(exports)) {
  if (target.includes("*")) {
    const dir = resolve(root, target.slice(0, target.indexOf("*")));
    if (!existsSync(dir) || readdirSync(dir).length === 0) missing.push(`exports ${key} -> ${target}`);
  } else if (!existsSync(resolve(root, target))) {
    missing.push(`exports ${key} -> ${target}`);
  }
}

if (missing.length) {
  console.error(`Missing files:\n  ${missing.join("\n  ")}`);
  process.exit(1);
}
console.log("fonts.css and exports resolve.");
