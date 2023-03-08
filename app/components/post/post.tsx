import { posts } from "@prisma/client";
import { Link } from "@remix-run/react";
import { FC } from "react";
import { DateTime } from 'luxon'

export const Post: FC<{ post: posts }> = ({ post }) => {
	const posted = DateTime.fromJSDate(post.posted!)

	return <article className="h-entry">
		<h2 className="p-name">
			<Link to={''}>
				{post.title}
			</Link>
		</h2>
		<time className="dt-published" title={posted.toLocaleString(DateTime.DATETIME_FULL)} dateTime={posted.toISO()}>
			{posted.toRelative()}
		</time>
		<address className="p-author h-card">
			by
			<Link to='/' className="u-url p-name">
				Kara Brightwell
			</Link>
		</address>

		{/* TODO */}
	</article>
}
