import { Form } from '@remix-run/react'
import { db } from '~/lib/db.server'
import bcrypt from 'bcrypt'
import { z } from 'zod'
import type { ActionArgs } from '@remix-run/node'
import { redirect } from '@remix-run/node'

const LoginFormSchema = z.object({
	username: z.string(),
	password: z.string(),
})

export async function action({ request }: ActionArgs) {
	const body = await request.formData()
	const { username, password } = LoginFormSchema.parse(Object.fromEntries(body))

	const user = await db.user.findUniqueOrThrow({
		where: {
			username,
		},
	})

	if (await bcrypt.compare(password, user.passwordDigest)) {
		// TODO session
		return redirect('/')
	} else {
		// TODO
		throw new Error('nope')
	}
}

export default () => (
	<Form method='post'>
		<input name='username' placeholder='username' />
		<input name='password' type='password' placeholder='password' />
		<input type='submit' value='Log in' />
	</Form>
)
