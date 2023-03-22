import { User } from "@prisma/client";
import { db } from "~/lib/db.server";
import { getSession } from "~/session";

export async function getCurrentUser(request: Request): Promise<User | undefined> {
	const session = await getSession(request.headers.get('cookie'))
	if(session.has('userId')) {
		return db.user.findUniqueOrThrow({
			where: {
				id: session.get('userId')
			}
		})
	}
}
