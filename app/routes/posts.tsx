import { ActionArgs } from '@remix-run/node'
import { Outlet } from '@remix-run/react'
import { z } from 'zod'
import { db } from '~/lib/db.server'

const PostFormSchema = z.object({
	title: z.string().optional(),
	body: z.string(),
	tags: z.string().default(''),
})

export async function action({ request }: ActionArgs) {
	const body = await request.formData()
	const { tags, ...data } = PostFormSchema.parse(Object.fromEntries(body))

	// const post = await db.post.create({
	// 	data: {
	// 		...data,
	// 		users: {
	// 			connect: {
	// 				id: 1
	// 			}
	// 		},
	// 		tags: {
	// 			connectOrCreate: tags.split(', ').map(tag => ({
	// 				tag: {
	// 					connectOrCreate: {
	// 						name: tag
	// 					}
	// 				}
	// 			}))
	// 		}
	// 	}
	// })
}

export default () => <Outlet />
