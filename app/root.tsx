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

type NavProps = { className?: string; children: ReactNode }

const Nav: FC<NavProps> = ({ className, children }) => (
	<header className={className}>
		<h1>
			<a href='/'>a pale slim ghost</a>
		</h1>
		<p>
			is <a href='/about'>Kara Brightwell</a>
		</p>

		{children}
	</header>
)

const getNavContent = (match: RouteMatch): NavProps =>
	match.handle?.navContent ?? {}

export default function App() {
	const matches = useMatches()
	const currentPage = matches[matches.length - 1]

	const navContent = getNavContent(currentPage)

	return (
		<html lang='en'>
			<head>
				<Meta />
				<Links />
			</head>
			<body>
				<Nav {...navContent} />
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
