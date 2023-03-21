import { LoaderArgs, redirect } from '@remix-run/node'
import { commitSession, getSession } from '~/session'

export async function loader({ request }: LoaderArgs) {
	const session = await getSession(request.headers.get('cookie'))
	session.unset('userId')

	return redirect('/', {
		headers: {
			'set-cookie': await commitSession(session),
		},
	})
}
