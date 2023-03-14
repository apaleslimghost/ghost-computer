import { LoaderArgs } from "@remix-run/node";
import { typedjson, useTypedLoaderData } from "remix-typedjson";
import { z } from "zod";
import { PostView } from "~/components/post/post";
import dbServer from "~/lib/db.server";

const PostParamsSchema = z.object({
	id: z.coerce.bigint()
})

export async function loader({ params }: LoaderArgs) {
	const { id } = PostParamsSchema.parse(params)

	const post = await dbServer.post.findFirstOrThrow({ where: {
		 id
	}})

	return typedjson({ post })
}

export default function PostPage() {
	const { post } = useTypedLoaderData<typeof loader>()

	return <PostView post={post} />
}
