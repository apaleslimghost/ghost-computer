import { Link } from '@remix-run/react'
import { cloneElement, FC } from 'react'
import { DateTime } from 'luxon'
import pluralize from 'pluralize'
import type { FullPost } from '~/models/post'
import { compiler, MarkdownToJSX } from 'markdown-to-jsx'
import React from 'react'

const MarkdownLink: FC<{
	href: string
	title?: string
	children: JSX.Element
}> = ({ href, title, children }) =>
	href.match(/^https?:/) && !href.startsWith('https://ghost.computer') ? (
		<a href={href} target='_blank' rel='nofollow noreferrer' title={title}>
			{children}
		</a>
	) : (
		<Link to={href.replace(/^https:\/\/ghost\.computer/, '')} title={title}>
			{children}
		</Link>
	)

const Markdown: FC<{
	body: string
	excerpt?: boolean
	readMore: JSX.Element
	options: MarkdownToJSX.Options
}> = ({ body, excerpt, options, readMore }) => {
	const rendered = compiler(body, {
		...options,
		forceWrapper: true,
		wrapper: React.Fragment,
	})

	if (excerpt && Array.isArray(rendered.props.children)) {
		return cloneElement(rendered, {
			children: rendered.props.children
				.slice(0, 3)
				.concat(rendered.props.children.length > 3 ? readMore : []),
		})
	}

	return rendered
}

export const PostView: FC<{ post: FullPost; excerpt?: boolean }> = ({
	post,
	excerpt,
}) => {
	const createdAt = DateTime.fromJSDate(post.createdAt)

	return (
		<article className='h-entry'>
			<h2 className='p-name'>
				<Link to={`/posts/${post.id}`}>{post.title}</Link>
			</h2>

			<time
				className='dt-published'
				title={createdAt.toLocaleString(DateTime.DATETIME_FULL)}
				dateTime={createdAt.toISO()}
			>
				{createdAt.toRelative()}
			</time>

			<address className='p-author h-card'>
				by&nbsp;
				<Link to='/' className='u-url p-name'>
					Kara Brightwell
				</Link>
			</address>

			{post.mentions.length > 0 ? (
				<Link to={`/posts/${post.id}#responses`}>
					{pluralize('response', post.mentions.length, true)}
				</Link>
			) : null}

			{post.tags.length > 0 ? (
				<ul className='tags'>
					{post.tags.map((tag) => (
						<li key={Number(tag.id)}>
							<Link to={`/tags/${tag.name}`}>{tag.name}</Link>
						</li>
					))}
				</ul>
			) : null}

			<div className='e-content'>
				<Markdown
					options={{
						overrides: {
							a: MarkdownLink,
						},
					}}
					body={post.body}
					excerpt={excerpt}
					readMore={
						<p>
							<Link to={`/posts/${post.id}`}>read more&hellip;</Link>
						</p>
					}
				/>
			</div>
		</article>
	)
}
