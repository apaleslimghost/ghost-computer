import { LoaderArgs } from '@remix-run/node'
import { typedjson, useTypedLoaderData } from 'remix-typedjson'
import { z } from 'zod'
import { PostForm } from '~/components/post/form'
import { db } from '~/lib/db.server'
import { postIncludes } from '~/models/post'

const PostParamsSchema = z.object({
	id: z.coerce.number(),
})

export async function loader({ params }: LoaderArgs) {
	const { id } = PostParamsSchema.parse(params)

	const post = await db.post.findFirstOrThrow({
		where: {
			id,
		},
		include: postIncludes,
	})

	return typedjson({ post })
}

export default () => {
	const { post } = useTypedLoaderData<typeof loader>()

	return <PostForm post={post} />
}
