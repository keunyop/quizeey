import { expect, it } from "vitest";
import { boundedJson, capabilityHash, forumRequest, guestCookieOptions, issueCapability, sameOrigin, verifiedAdminAllowed } from "./guest-policy";
it("issues unpredictable server-only capabilities with hash verification and strict cookie settings", () => {
  const a = issueCapability(); const b = issueCapability();
  expect(a.token).not.toBe(b.token); expect(a.verificationHash).toMatch(/^[a-f0-9]{64}$/);
  expect(capabilityHash(a.token)).toBe(a.verificationHash); expect(a.verificationHash).not.toContain(a.token);
  expect(guestCookieOptions).toMatchObject({ httpOnly: true, secure: true, sameSite: "strict", path: "/" });
  expect(() => capabilityHash("guessable-name")).toThrow();
});
it("rejects missing, cross-origin and cross-site CSRF inputs", () => {
  const url = "https://quizeey.com/api/forum";
  expect(sameOrigin(new Request(url, { headers: { Origin: "https://quizeey.com" } }), "https://quizeey.com")).toBe(true);
  expect(sameOrigin(new Request(url), "https://quizeey.com")).toBe(false);
  expect(sameOrigin(new Request(url, { headers: { Origin: "https://evil.test" } }), "https://quizeey.com")).toBe(false);
  expect(sameOrigin(new Request(url, { headers: { Origin: "https://quizeey.com", "Sec-Fetch-Site": "cross-site" } }), "https://quizeey.com")).toBe(false);
});
it("normalizes empty/whitespace/optional display names without using names as identity", () => {
  const sample = { action: "create", examId: "5", locale: "ko", title: "Title", body: "Text" };
  for (const name of [undefined, "", " \t\n", "\u00a0\u3000"]) {
    const parsed = forumRequest.parse({ ...sample, ...(name === undefined ? {} : { displayName: name }) });
    expect("displayName" in parsed && parsed.displayName).toBeNull();
  }
  expect(forumRequest.safeParse({ ...sample, ownerName: "Admin" }).success).toBe(false);
});
it("bounds text/links and keeps text literal rather than accepting executable HTML", () => {
  const sample = { action: "create", examId: "5", locale: "ko", title: "Title", body: "<script>literal text</script>" };
  expect(forumRequest.parse(sample)).toMatchObject({ body: "<script>literal text</script>" });
  expect(forumRequest.safeParse({ ...sample, body: "x".repeat(4001) }).success).toBe(false);
  expect(forumRequest.safeParse({ ...sample, body: "https://a https://b https://c https://d" }).success).toBe(false);
});
it("bounds the streamed body independently of Content-Length", async () => {
  const request = new Request("https://quizeey.com", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ text: "x".repeat(25000) }) });
  await expect(boundedJson(request)).rejects.toThrow(/limit/);
  await expect(boundedJson(new Request("https://quizeey.com", { method: "POST", body: "x" }))).rejects.toThrow(/JSON/);
});
it("admin authorization requires verified provider identity and explicit target allowlist", () => {
  const user = "00000000-0000-4000-8000-000000000001";
  expect(verifiedAdminAllowed(user, [user])).toBe(true);
  expect(verifiedAdminAllowed("Admin", ["Admin"])).toBe(false);
  expect(verifiedAdminAllowed(user, [])).toBe(false);
});
