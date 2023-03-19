import type { Prisma } from '@prisma/client'

export const postIncludes = {
	tags: { include: { tag: true } },
	mentions: true,
} satisfies Prisma.PostInclude

export type FullPost = Prisma.PostGetPayload<{ include: typeof postIncludes }>
