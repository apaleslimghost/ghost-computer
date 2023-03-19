import { Prisma } from '@prisma/client'
import { db } from '~/lib/db.server'

export const postIncludes = {
	tags: { include: { tag: true } },
	mentions: true,
} satisfies Prisma.PostInclude

export type FullPost = Prisma.PostGetPayload<{ include: typeof postIncludes }>
