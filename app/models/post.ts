import { Prisma } from "@prisma/client"
import { db } from "~/lib/db.server"

export const postIncludes: Prisma.PostInclude = {
	tags: {include: {tag: true}},
	mentions: true
} as const

export type FullPost = Prisma.PostGetPayload<{ include: typeof postIncludes }>
