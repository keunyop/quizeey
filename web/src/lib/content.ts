import sanitizeHtml from "sanitize-html";
import staticPages from '../../fixtures/legacy-pages.json' with { type: 'json' };
import { siteCopy } from './site-copy';

// Technical placeholders such as <AMI-ID>, <CTRL> and <T extends Number>
// occur in the legacy archive. They must remain visible as text. This pass
// recognizes attribute-free tokens only; sanitize-html remains the security
// boundary for the entire result, including malformed/active HTML.
const htmlElements = new Set((
  "a abbr address area article aside audio b base bdi bdo blockquote body br button canvas caption cite code col colgroup " +
  "data datalist dd del details dfn dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 " +
  "head header hgroup hr html i iframe img input ins kbd label legend li link main map mark menu meta meter nav noscript " +
  "object ol optgroup option output p picture pre progress q rp rt ruby s samp script search section select selectedcontent " +
  "slot small source span strong style sub summary sup table tbody td template textarea tfoot th thead time title tr track u ul var video wbr " +
  "acronym applet basefont big center dir font frame frameset marquee noframes param plaintext strike tt xmp svg math"
).split(" "));

export function preserveTechnicalTokens(input: string): string {
  return input.replace(/<\/?([A-Za-z][\w:-]*)(?:[ \u00a0]+[A-Za-z0-9_-]+)*[ \t]*\/?>/g, (token: string, name: string) =>
    htmlElements.has(name.toLowerCase()) ? token : token.replace(/</g, "&lt;").replace(/>/g, "&gt;"));
}

// Server only: sanitize before content crosses the server/client serialization boundary.
export function learningHtml(input: string): string {
  return sanitizeHtml(preserveTechnicalTokens(input), {
    allowedTags: ["p", "br", "strong", "em", "b", "i", "u", "s", "sub", "sup", "ul", "ol", "li", "blockquote", "pre", "code", "table", "caption", "thead", "tbody", "tfoot", "tr", "th", "td", "img", "a", "span", "div"],
    allowedAttributes: {
      a: ["href", "title", "rel"], img: ["src", "alt", "width", "height", "loading"],
      th: ["scope", "colspan", "rowspan"], td: ["colspan", "rowspan"],
    },
    allowedSchemes: ["https"], allowProtocolRelative: false,
    transformTags: {
      a: sanitizeHtml.simpleTransform("a", { rel: "noopener noreferrer" }),
      img: (tagName, attribs) => {
        // Asset manifest/rights must authorize further domains before production.
        const src = attribs.src ?? "";
        const allowed = src.startsWith("/") && !src.startsWith("//") && !src.includes("\\");
        return { tagName: allowed ? "img" : "span", attribs: allowed ? { ...attribs, loading: "lazy" } : {} };
      },
    },
  });
}

export function staticPage(path: string) {
  const page=siteCopy[path as keyof typeof siteCopy] ?? staticPages[path as keyof typeof staticPages];
  if(!page)return undefined;
  return {lang:page.lang,html:sanitizeHtml(page.html,{
    allowedTags:['h2','h3','p','br','strong','em','b','i','ul','ol','li','blockquote','table','thead','tbody','tr','th','td','img','a','div','span'],
    allowedAttributes:{a:['href','rel'],img:['src','alt','width','height','loading'],th:['scope','colspan','rowspan'],td:['colspan','rowspan']},
    allowedSchemes:['https','mailto'],allowProtocolRelative:false,
    transformTags:{
      h5:sanitizeHtml.simpleTransform('h2',{}),h6:sanitizeHtml.simpleTransform('h3',{}),label:sanitizeHtml.simpleTransform('p',{}),
      a:sanitizeHtml.simpleTransform('a',{rel:'noopener noreferrer'}),
      img:(tag,attributes)=>({tagName:attributes.src==='/img/awsCertifiedDeveloper-associate_badge.png'?'img':'span',attribs:attributes.src==='/img/awsCertifiedDeveloper-associate_badge.png'?{...attributes,loading:'lazy'}:{}}),
    },
  })};
}
