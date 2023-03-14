import { LoaderArgs } from "@remix-run/node";
import { typedjson, TypedMetaFunction, useTypedLoaderData } from "remix-typedjson";
import { z } from "zod";
import { PostView } from "~/components/post/post";
import { db } from "~/lib/db.server";

const PostParamsSchema = z.object({
	id: z.coerce.bigint()
})

export async function loader({ params }: LoaderArgs) {
	const { id } = PostParamsSchema.parse(params)

	const post = await db.post.findFirstOrThrow({ where: {
		 id
	}, include: {
		tags: {
			include: {
				tag: true
			}
		},
		mentions: true
	}})

	return typedjson({ post })
}

export const meta: TypedMetaFunction<typeof loader> = ({ data }) => ({
	title: `${data.post.title ?? data.post.body ?? 'um what even is a post that has no title or body'} ☰ a pale slim ghost`
})

export default function PostPage() {
	const { post } = useTypedLoaderData<typeof loader>()

	return <PostView post={post} />
}
