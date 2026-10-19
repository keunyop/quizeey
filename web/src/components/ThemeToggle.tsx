"use client";

import { useSyncExternalStore } from "react";
import type { Locale } from "@/lib/contracts";
import { Icon } from "./Icon";

const eventName = "quizeey:theme-change";
function subscribe(listener: () => void) {
  window.addEventListener(eventName, listener);
  return () => window.removeEventListener(eventName, listener);
}
function snapshot() { return document.documentElement.dataset.theme === "dark"; }

export function ThemeToggle({ locale }: { locale: Locale }) {
  const dark = useSyncExternalStore(subscribe, snapshot, () => false);
  const label = locale === "ko" ? dark ? "라이트 모드로 전환" : "다크 모드로 전환" : dark ? "Switch to light mode" : "Switch to dark mode";
  return <button type="button" className="theme-toggle" aria-label={label} title={label} onClick={() => {
    const next = dark ? "light" : "dark";
    document.documentElement.dataset.themePreference = next;
    document.documentElement.dataset.theme = next;
    try { localStorage.setItem("quizeey:theme", next); } catch { /* Keep the selected theme in this tab. */ }
    window.dispatchEvent(new Event(eventName));
  }}><Icon name={dark ? "sun" : "moon"} /><span>{locale === "ko" ? dark ? "라이트" : "다크" : dark ? "Light" : "Dark"}</span></button>;
}
