import { LoaderArgs } from '@remix-run/node'
import { typedjson, useTypedLoaderData } from 'remix-typedjson'
import { PostForm } from '~/components/post/form'
import { PostView } from '~/components/post/post'
import { db } from '~/lib/db.server'
import { postIncludes } from '~/models/post'
import { userSession } from '~/models/user'

export const handle = {
	bodyClass: 'home',
	navContent: (
		<section>
			she'll haunt you with:
			<ul>
				<li>
					<a href='https://asmpts.com' target='blank' rel='noopener'>
						big kicks & rich noises
					</a>
				</li>
				<li>
					<a href='https://paleslimghost.store' target='blank' rel='noopener'>
						synthesisers and synthesiser accessories
					</a>
				</li>
				<li>
					<a
						href='https://github.com/apaleslimghost'
						target='blank'
						rel='noopener'
					>
						error messages that tell you how they can be fixed
					</a>
				</li>
				<li>
					<a
						href='https://cathode.church/@apaleslimghost'
						target='blank'
						rel='me noopener'
					>
						shitposts
					</a>
				</li>
			</ul>
		</section>
	),
}

export async function loader({ request }: LoaderArgs) {
	const { loggedIn } = await userSession(request)
	const posts = await db.post.findMany({
		orderBy: {
			createdAt: 'desc',
		},
		include: postIncludes,
	})

	return typedjson({ posts, loggedIn })
}

export default function Index() {
	const { posts, loggedIn } = useTypedLoaderData<typeof loader>()

	return (
		<>
			{posts.map((post) => (
				<PostView key={post.id.toString()} post={post} excerpt />
			))}

			{loggedIn && <PostForm />}
		</>
	)
}
