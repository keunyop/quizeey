"use client";
import { useState, useSyncExternalStore } from "react";
import type { LegacyRoute, Locale } from "@/lib/contracts";
import { categories, categoryNames, examCategory, examName, matchesExam, readFavorites, sortExams, type Category, type ExamPopularity, type ExamSort } from "@/lib/exam-catalog";
import { Icon } from "./Icon";
import { ExamLink } from "./ExamLink";
import { AdSlot } from "./Monetization";

const favoriteKey = "quizeey:favorite-exams:v1";
function subscribe(listener: () => void) {
  const onStorage = (event: StorageEvent) => { if (event.key === favoriteKey || event.key === null) listener(); };
  window.addEventListener("storage", onStorage);
  return () => window.removeEventListener("storage", onStorage);
}
function snapshot() { try { return localStorage.getItem(favoriteKey); } catch { return null; } }

export function ExamSearch({ routes, locale, popularity }: { routes: LegacyRoute[]; locale: Locale; popularity: ExamPopularity }) {
  const en = locale === "en";
  const [search, setSearch] = useState("");
  const [category, setCategory] = useState<Category>("all");
  const [savedOnly, setSavedOnly] = useState(false);
  const [sort, setSort] = useState<ExamSort>("popular");
  const [limit, setLimit] = useState(18);
  const [storageError, setStorageError] = useState(false);
  const [fallback, setFallback] = useState<string[] | null>(null);
  const raw = useSyncExternalStore(subscribe, snapshot, () => null);
  const favorites = fallback ?? readFavorites(raw);
  const names = categoryNames[locale];
  const savedCount = routes.filter((r) => favorites.includes(r.path)).length;
  const filtered = sortExams(routes.filter((r) => matchesExam(r, search) && (category === "all" || examCategory(r) === category) && (!savedOnly || favorites.includes(r.path))), locale, sort, popularity);
  const visibleCategories = categories.filter((c) => c === "all" || routes.some((r) => examCategory(r) === c));
  function reset() { setSearch(""); setCategory("all"); setSavedOnly(false); setLimit(18); }
  function toggleFavorite(path: string) {
    const paths = favorites.includes(path) ? favorites.filter((value) => value !== path) : [...favorites, path];
    try {
      localStorage.setItem(favoriteKey, JSON.stringify({ schema: 1, paths })); setFallback(null); setStorageError(false);
      window.dispatchEvent(new StorageEvent("storage", { key: favoriteKey }));
    } catch { setFallback(paths); setStorageError(true); }
  }
  function cards(items:LegacyRoute[]){return items.map((r)=>{
    const c=examCategory(r),name=examName(r),saved=favorites.includes(r.path);
    return <li key={r.path} className={`exam-card category-${c}`}>
      <ExamLink href={r.path}><span className="exam-category">{names[c]}</span><h3>{name}</h3><span className="exam-card-bottom">{en?'Practice questions':'기출문제 풀기'}<Icon name="arrow"/></span></ExamLink>
      <button className="icon-button favorite-button" aria-label={`${name} ${saved?en?'Remove favorite':'즐겨찾기 해제':en?'Add favorite':'즐겨찾기'}`} aria-pressed={saved} onClick={()=>toggleFavorite(r.path)}><Icon name="bookmark"/></button>
    </li>;
  });}
  return <>
    <section className="catalog-hero" aria-labelledby="catalog-heading">
      <h1 id="catalog-heading">{en ? "Practice exams" : "자격증 기출문제"}</h1>
      <p className="catalog-description">{en ? 'Free English certification practice for learners in the United States and Canada. Explore AWS, Azure, Cisco and more, check your answers and review mistakes.' : 'SQLD, 정보처리기사, 전기기사 등 한국 자격증 기출문제와 연습문제를 풀어보세요. 정답 확인과 오답 복습으로 CBT 시험을 준비할 수 있습니다.'}</p>
      <div className="search-field"><Icon name="search" /><label className="sr-only" htmlFor="exam-search">{en ? "Search exams" : "자격증 검색"}</label>
        <input id="exam-search" type="search" autoComplete="off" placeholder={en ? "Find your exam" : "어떤 자격증을 준비하세요?"} value={search} onChange={(e) => { setSearch(e.target.value); setLimit(18); }} />
        {search && <button className="icon-button" aria-label={en ? "Clear search" : "검색어 지우기"} onClick={() => { setSearch(""); setLimit(18); document.getElementById("exam-search")?.focus(); }}><Icon name="close" /></button>}
      </div>
    </section>
    <section className="catalog" aria-labelledby="exams-heading">
      <div className="catalog-heading"><div><h2 id="exams-heading">{en ? "Explore exams" : "시험 둘러보기"}</h2><span className="count-badge">{routes.length}</span></div></div>
      <div className="catalog-tabs" role="group" aria-label={en ? "Exam collection" : "시험 목록 선택"}>
        <button aria-pressed={!savedOnly} onClick={() => { setSavedOnly(false); setLimit(18); }}><Icon name="grid" />{en ? "All exams" : "전체 시험"}</button>
        <button aria-pressed={savedOnly} onClick={() => { setSavedOnly(true); setLimit(18); }}><Icon name="bookmark" />{en ? "Favorites" : "즐겨찾기"}<span>{savedCount}</span></button>
      </div>
      <div className="category-filters" role="group" aria-label={en ? "Exam category" : "시험 분야"}>{visibleCategories.map((c) => <button key={c} aria-pressed={category === c} onClick={() => { setCategory(c); setLimit(18); }}>{names[c]}</button>)}</div>
      <div className="results-line"><p role="status">{en ? `${filtered.length} exams` : `${filtered.length}개의 시험`}{search && <span> · “{search}”</span>}</p><div className="catalog-controls">
        {(search || category !== "all") && <button className="text-button" onClick={reset}>{en ? "Reset filters" : "필터 초기화"}<Icon name="refresh" /></button>}
        <label className="sr-only" htmlFor="exam-sort">{en ? "Sort exams" : "시험 정렬"}</label>
        <select id="exam-sort" value={sort} onChange={(event) => { setSort(event.target.value as ExamSort); setLimit(18); }}>
          <option value="popular">{en ? "Most popular" : "인기도순"}</option>
          <option value="name">{en ? "Alphabetical" : "가나다순"}</option>
        </select>
      </div></div>
      <ul className="exam-list">{cards(filtered.slice(0,6))}</ul>
      <AdSlot kind="infeed" locale={locale} eligible={!search.trim() && category === "all" && !savedOnly && filtered.length > 6} />
      {filtered.length>6&&<ul className="exam-list exam-list-continuation">{cards(filtered.slice(6,limit))}</ul>}
      {!filtered.length && <div className="empty-state"><div className="empty-icon"><Icon name={savedOnly ? "bookmark" : "search"} /></div><h3>{savedOnly && !savedCount ? en ? "Your favorites, all in one place" : "자주 찾는 시험을 모아보세요" : en ? "No matching exams" : "검색 결과가 없습니다"}</h3><p>{savedOnly && !savedCount ? en ? "Use the bookmark on an exam to save it here." : "시험 카드의 북마크를 누르면 여기에 모아볼 수 있어요." : en ? "Try another name or category." : "다른 검색어나 분야로 찾아보세요."}</p><button onClick={reset}>{en ? "View all exams" : "전체 시험 보기"}<Icon name="arrow" /></button></div>}
      {filtered.length > limit && <div className="load-more"><button onClick={() => setLimit((value) => value + 18)}>{en ? "Show more" : "시험 더 보기"}<span>{Math.min(limit, filtered.length)} / {filtered.length}</span></button></div>}
      {storageError && <p role="status" className="error">{en ? "Favorites cannot be saved in this browser." : "이 브라우저에 즐겨찾기를 저장할 수 없습니다."}</p>}
    </section>
  </>;
}
