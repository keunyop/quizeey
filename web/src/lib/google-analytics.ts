export function analyticsLocation(pagePath:string,search:string){
  const url=new URL(pagePath,'https://quizeey.com');
  const input=new URLSearchParams(search);
  // Keep ordinary campaign attribution without forwarding arbitrary URL/form values.
  for(const key of ['utm_source','utm_medium','utm_campaign']){
    const value=input.get(key);if(value&&/^[A-Za-z0-9._-]{1,64}$/.test(value))url.searchParams.set(key,value);
  }
  return url.href;
}
export function analyticsReferrer(input:string){try{const url=new URL(input);return ['http:','https:'].includes(url.protocol)?url.origin+url.pathname:'';}catch{return '';}}
