import { Form } from '@remix-run/react'
import { db } from '~/lib/db.server'
import bcrypt from 'bcrypt'
import { z } from 'zod'
import type { ActionArgs, LoaderArgs } from '@remix-run/node'
import { redirect } from '@remix-run/node'
import { commitSession, getSession } from '~/session'

const LoginFormSchema = z.object({
	username: z.string(),
	password: z.string(),
})

export async function loader({ request }: LoaderArgs) {
	const session = await getSession(request.headers.get('cookie'))
	if (session.get('userId')) {
		return redirect('/', {
			headers: {
				'set-cookie': await commitSession(session),
			},
		})
	}

	return null
}

export async function action({ request }: ActionArgs) {
	const session = await getSession(request.headers.get('cookie'))
	const body = await request.formData()
	const { username, password } = LoginFormSchema.parse(Object.fromEntries(body))

	const user = await db.user.findUniqueOrThrow({
		where: {
			username,
		},
	})

	if (await bcrypt.compare(password, user.passwordDigest)) {
		session.set('userId', user.id)

		return redirect('/', {
			headers: {
				'set-cookie': await commitSession(session),
			},
		})
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
