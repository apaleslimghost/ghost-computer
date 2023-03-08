import type { MetaFunction, LinksFunction } from "@remix-run/node";
import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  RouteMatch,
  Scripts,
  ScrollRestoration,
  useMatches,
} from "@remix-run/react";
import { ReactNode } from "react";
import { z } from "zod";

export const meta: MetaFunction = () => ({
  charset: "utf-8",
  title: "a pale slim ghost",
  viewport: "width=device-width,initial-scale=1",
});

export const links: LinksFunction = () => ([
  { rel: 'icon', href: '/favicon.svg' },
  // TODO rss
])

const Nav = ({ children }: { children: ReactNode }) => <header>
  <h1><a href="/">a pale slim ghost</a></h1>
  <p>is <a href="/about">Kara Brightwell</a></p>

  {children}
</header>

const getNavContent = (match: RouteMatch): ReactNode => match.handle?.navContent ?? null

export default function App() {
  const matches = useMatches()
  const currentPage = matches[matches.length - 1]

  const navContent = getNavContent(currentPage)

  return (
    <html lang="en">
      <head>
        <Meta />
        <Links />
      </head>
      <body>
        <Nav>{navContent}</Nav>
        <main>
          <Outlet />
        </main>
        <ScrollRestoration />
        <Scripts />
        <LiveReload />
      </body>
    </html>
  );
}
