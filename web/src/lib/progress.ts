export type Attempt = { selected: string[]; correct: boolean };
export type Progress = {
  schema: 1; contentVersion: string; ids: string[]; index: number;
  attempts: Record<string, Attempt>; bookmarks: string[]; choiceOrders: Record<string, string[]>; reviewIds: string[] | null;
};
export function emptyProgress(ids: string[], contentVersion: string): Progress {
  return { schema: 1, contentVersion, ids, index: 0, attempts: {}, bookmarks: [], choiceOrders: {}, reviewIds: null };
}
export function readProgress(raw: string | null, ids: string[], contentVersion: string): Progress | null {
  if (!raw || raw.length > 100_000) return null;
  try {
    const value = JSON.parse(raw) as Progress;
    if (value.schema !== 1 || value.contentVersion !== contentVersion || JSON.stringify(value.ids) !== JSON.stringify(ids)) return null;
    if (!Number.isInteger(value.index) || value.index < 0 || value.index > ids.length || !Array.isArray(value.bookmarks)) return null;
    if (!value.attempts || typeof value.attempts !== "object" || Array.isArray(value.attempts) || !value.choiceOrders || typeof value.choiceOrders !== "object") return null;
    if (value.bookmarks.some((id) => typeof id !== "string" || !ids.includes(id))) return null;
    if (value.reviewIds !== null && (!Array.isArray(value.reviewIds) || value.reviewIds.some((id) => typeof id !== "string" || !ids.includes(id)))) return null;
    if (Object.entries(value.attempts).some(([id, a]) => !ids.includes(id) || !a || !Array.isArray(a.selected) || a.selected.length > 100 || a.selected.some((id) => typeof id !== "string") || typeof a.correct !== "boolean")) return null;
    if (Object.entries(value.choiceOrders).some(([id, order]) => !ids.includes(id) || !Array.isArray(order) || order.length > 100 || order.some((choice) => typeof choice !== "string"))) return null;
    return value;
  } catch { return null; }
}
