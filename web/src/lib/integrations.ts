// Ports keep lifecycle tests independent of live ad/analytics networks.
export type IntegrationPolicy = {
  stage: "local" | "preview" | "production"; consent: boolean; verified: boolean;
};
export interface AdPort<T extends object> {
  loadScript: (publisher: string) => Promise<void>;
  reserve: (slot: T, minHeight: number) => void;
  initialize: (slot: T, slotId: string) => void;
}
export const PUBLISHER = "ca-pub-8362228066874729";
const SLOTS = new Set(["1033140566", "8990988805"]);
export class AdLifecycle<T extends object> {
  private script: Promise<void> | undefined;
  private attempted = new WeakSet<T>();
  constructor(private policy: IntegrationPolicy, private port: AdPort<T>) {}
  updatePolicy(policy:IntegrationPolicy){this.policy=policy;}
  async mount(slot: T, slotId: string, minHeight: number): Promise<boolean> {
    if (this.policy.stage !== "production" || !this.policy.consent || !this.policy.verified) return false;
    if (!SLOTS.has(slotId) || !Number.isFinite(minHeight) || minHeight < 100) throw new Error("Unverified ad slot configuration");
    if (this.attempted.has(slot)) return false;
    this.attempted.add(slot);
    this.port.reserve(slot, minHeight);
    // Keep a rejected load promise: no loops, timers or automatic ad refresh retries.
    this.script ??= this.port.loadScript(PUBLISHER);
    try { await this.script; if(!this.policy.consent||!this.policy.verified)return false;this.port.initialize(slot, slotId); return true; }
    catch { return false; }
  }
}

export const eventNames = ["question_start", "answer_submit", "explanation_open", "practice_complete", "bookmark_add", "forum_post_created", "locale_selected"] as const;
export type EventName = (typeof eventNames)[number];
export type QuizPayload = { test_id?: string; quest_id?: string; locale: "ko" | "en"; correct?: boolean };
export function measure(policy: IntegrationPolicy, send: (event: EventName, payload: QuizPayload) => void, event: EventName, payload: QuizPayload) {
  if (policy.stage !== "production" || !policy.consent || !policy.verified) return false;
  if (!eventNames.includes(event) || !["ko", "en"].includes(payload.locale)) throw new Error("Invalid analytics event");
  if (Object.keys(payload).some((key) => !["test_id", "quest_id", "locale", "correct"].includes(key))) throw new Error("Disallowed analytics payload");
  for (const id of [payload.test_id, payload.quest_id]) if (id !== undefined && !/^[1-9]\d{0,18}$/.test(id)) throw new Error("Invalid analytics identifier");
  if (payload.correct !== undefined && typeof payload.correct !== "boolean") throw new Error("Invalid analytics result");
  send(event, payload);
  return true;
}
