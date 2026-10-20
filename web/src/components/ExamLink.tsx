"use client";

import type { MouseEvent, ReactNode } from "react";

/** Record explicit exam navigation, without delaying the link's native behavior. */
export function ExamLink({ href, children }: { href: string; children: ReactNode }) {
  function record(event: MouseEvent<HTMLAnchorElement>) {
    if (event.defaultPrevented || (event.type === "auxclick" && event.button !== 1)) return;
    void fetch("/api/exams/click", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ path: href }),
      keepalive: true,
      credentials: "same-origin",
    }).catch(() => { /* A recording failure must not interrupt practice. */ });
  }
  return <a href={href} data-google-vignette="false" onClick={record} onAuxClick={record}>{children}</a>;
}
