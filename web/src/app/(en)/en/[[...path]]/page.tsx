import { RouteView, routeMetadata, type Query } from "@/components/RouteView";
type Props = { params: Promise<{path?: string[]}>; searchParams: Promise<Query> };
function pathname(path?: string[]) { return "/en" + (path?.length ? "/" + path.join("/") : ""); }
export async function generateMetadata({ params, searchParams }: Props) {
  const [p, query] = await Promise.all([params, searchParams]);
  return routeMetadata(pathname(p.path), query);
}
export default async function Page({ params, searchParams }: Props) {
  const [p, query] = await Promise.all([params, searchParams]);
  return <RouteView path={pathname(p.path)} query={query} />;
}
