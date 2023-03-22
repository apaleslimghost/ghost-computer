import { ActionArgs, redirect } from '@remix-run/node'
import { Outlet } from '@remix-run/react'
import { z } from 'zod'
import { db } from '~/lib/db.server'
import { userSession } from '~/models/user'

const PostFormSchema = z.object({
	title: z.string().optional(),
	body: z.string(),
	tags: z.string().default(''),
})

export async function action({ request }: ActionArgs) {
	const { userId, loggedIn } = await userSession(request)

	if (!loggedIn) {
		// TODO
		throw new Error('nope')
	}

	const body = await request.formData()
	const { tags, ...data } = PostFormSchema.parse(Object.fromEntries(body))

	const post = await db.post.create({
		data: {
			...data,
			users: {
				connect: {
					id: userId,
				},
			},
			tags: {
				connectOrCreate: tags.split(', ').map((tag) => ({
					where: {
						name: tag,
					},
					create: {
						name: tag,
					},
				})),
			},
		},
	})

	return redirect(`/posts/${post.id}`)
}

export default () => <Outlet />
