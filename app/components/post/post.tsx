import { Post } from "@prisma/client";
import { Link } from "@remix-run/react";
import { FC } from "react";
import { DateTime } from 'luxon'

export const PostView: FC<{ post: Post }> = ({ post }) => {
	const createdAt = DateTime.fromJSDate(post.createdAt)

	return <article className="h-entry">
		<h2 className="p-name">
			<Link to={`/posts/${post.id}`}>
				{post.title}
			</Link>
		</h2>
		<time className="dt-published" title={createdAt.toLocaleString(DateTime.DATETIME_FULL)} dateTime={createdAt.toISO()}>
			{createdAt.toRelative()}
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
