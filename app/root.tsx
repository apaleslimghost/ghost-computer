import type { MetaFunction, LinksFunction } from '@remix-run/node'
import type { RouteMatch } from '@remix-run/react'
import {
	Links,
	LiveReload,
	Meta,
	Outlet,
	Scripts,
	ScrollRestoration,
	useMatches,
} from '@remix-run/react'
import type { FC, ReactNode } from 'react'

import styles from './styles/main.css'

export const meta: MetaFunction = () => ({
	charset: 'utf-8',
	title: 'a pale slim ghost',
	viewport: 'width=device-width,initial-scale=1',
})

export const links: LinksFunction = () => [
	{ rel: 'icon', href: '/favicon.svg' },
	{ rel: 'stylesheet', href: styles },
	// TODO rss
]

const Nav: FC<{ children: ReactNode }> = ({ children }) => (
	<header>
		<h1>
			<a href='/'>a pale slim ghost</a>
		</h1>
		<p>
			is <a href='/about'>Kara Brightwell</a>
		</p>

		{children}
	</header>
)

const getNavContent = (match: RouteMatch): ReactNode =>
	match.handle?.navContent ?? null

const getBodyClass = (match: RouteMatch): string | undefined =>
	match.handle?.bodyClass

export default function App() {
	const matches = useMatches()
	const currentPage = matches[matches.length - 1]

	const navContent = getNavContent(currentPage)
	const bodyClass = getBodyClass(currentPage)

	return (
		<html lang='en'>
			<head>
				<Meta />
				<Links />
			</head>
			<body className={bodyClass}>
				<Nav>{navContent}</Nav>
				<main>
					<Outlet />
				</main>
				<ScrollRestoration />
				<Scripts />
				<LiveReload />
			</body>
		</html>
	)
}
