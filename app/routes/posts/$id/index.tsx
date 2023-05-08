import type { ActionArgs, LoaderArgs } from '@remix-run/node'
import type { TypedMetaFunction } from 'remix-typedjson'
import { typedjson, useTypedLoaderData } from 'remix-typedjson'
import { z } from 'zod'
import { PostView } from '~/components/post/post'
import { db } from '~/lib/db.server'
import { postIncludes } from '~/models/post'

const PostParamsSchema = z.object({
	id: z.coerce.number(),
})

const PostActionSchema = z.object({
	action: z.literal('like'),
})

export async function action({ params, request }: ActionArgs) {
	const { id } = PostParamsSchema.parse(params)
	const body = await request.formData()
	const { action } = PostActionSchema.parse(Object.fromEntries(body))

	switch (action) {
		case 'like': {
			await db.post.update({
				where: { id },
				data: {
					likes: {
						increment: 1,
					},
				},
			})
		}
	}
}

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

export const meta: TypedMetaFunction<typeof loader> = ({ data }) => ({
	title: `${
		data.post.title ??
		data.post.body ??
		'um what even is a post that has no title or body'
	} ☰ a pale slim ghost`,
})

export default function PostPage() {
	const { post } = useTypedLoaderData<typeof loader>()

	return <PostView post={post} />
}
