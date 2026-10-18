import { RouteView, routeMetadata, type Query } from "@/components/RouteView";
type Props = { params: Promise<{path?: string[]}>; searchParams: Promise<Query> };
export async function generateMetadata({ params, searchParams }: Props) {
  const [p, query] = await Promise.all([params, searchParams]);
  return routeMetadata("/" + (p.path ?? []).join("/"), query);
}
export default async function Page({ params, searchParams }: Props) {
  const [p, query] = await Promise.all([params, searchParams]);
  return <RouteView path={"/" + (p.path ?? []).join("/")} query={query} />;
}
