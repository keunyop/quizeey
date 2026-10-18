import localFont from "next/font/local";

// Pretendard v1.3.9, distributed with its SIL Open Font License in fonts/OFL.txt.
export const uiFont = localFont({
  src: "./fonts/PretendardVariable.woff2",
  variable: "--font-ui",
  weight: "100 900",
  display: "swap",
  fallback: ["Arial", "sans-serif"],
});
