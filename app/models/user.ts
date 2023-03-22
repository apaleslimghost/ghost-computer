import { User } from "@prisma/client";
import { db } from "~/lib/db.server";
import { getSession } from "~/session";

type UserSession = {
	loggedIn: boolean,
	getUser: () => Promise<User | undefined>
}

export async function userSession(request: Request): Promise<UserSession> {
	const session = await getSession(request.headers.get('cookie'))
	const userId = session.get('userId')

	return {
		loggedIn: Boolean(userId),
		getUser: async () => userId ? db.user.findUniqueOrThrow({
			where: {
				id: userId
			}
		}) : undefined
	}
}
