import { defineConfig, globalIgnores } from "eslint/config";
import js from "@eslint/js";
import ts from "typescript-eslint";
import hooks from "eslint-plugin-react-hooks";

export default defineConfig([
  { files: ["**/*.{ts,tsx}"], extends: [js.configs.recommended, ...ts.configs.recommended, hooks.configs.flat.recommended] },
  globalIgnores([".next/**", "next-env.d.ts", "playwright-report/**", "test-results/**"]),
]);
