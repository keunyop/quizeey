import "../globals.css";
import { uiFont } from "../font";
import { ThemeScript } from "@/components/ThemeScript";
export const metadata = { icons: { icon: "/img/favicon.ico", shortcut: "/img/favicon.ico" } };
export default function Layout({ children }: { children: React.ReactNode }) {
  return <html lang="ko" className={uiFont.variable} suppressHydrationWarning><head><ThemeScript /></head><body>{children}</body></html>;
}
