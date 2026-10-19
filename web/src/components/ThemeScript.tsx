// Runs before paint in both root layouts, including when storage is unavailable.
const initialize = `(function(){var k='quizeey:theme',r=document.documentElement,m=window.matchMedia('(prefers-color-scheme: dark)'),chosen=null;try{chosen=localStorage.getItem(k)}catch(e){}function preference(v){if(v==='dark'||v==='light')r.dataset.themePreference=v;else delete r.dataset.themePreference}function apply(){var v=r.dataset.themePreference;r.dataset.theme=v==='dark'||v!=='light'&&m.matches?'dark':'light';window.dispatchEvent(new Event('quizeey:theme-change'))}preference(chosen);apply();m.addEventListener('change',function(){if(!r.dataset.themePreference)apply()});window.addEventListener('storage',function(e){if(e.key===k||e.key===null){preference(e.newValue);apply()}})})()`;

export function ThemeScript() {
  return <script dangerouslySetInnerHTML={{ __html: initialize }} />;
}
