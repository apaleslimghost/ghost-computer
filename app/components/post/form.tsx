import { Form } from '@remix-run/react'
import { FC } from 'react'
import { FullPost } from '~/models/post'

export const PostForm: FC<{ post?: FullPost }> = ({ post }) => (
	<Form action={`/posts${post ? `/${post.id}` : ''}`} method='post'>
		<h2 className='field'>
			<input
				name='title'
				placeholder='new post'
				defaultValue={post?.title ?? undefined}
			/>
		</h2>

		<div className='field'>
			<input
				name='tags'
				placeholder='tags...'
				defaultValue={
					post ? post.tags.map((tag) => tag.name).join(', ') : undefined
				}
			/>
		</div>

		<div className='field'>
			<textarea required name='body' defaultValue={post?.body} />
		</div>

		<div className='actions'>
			<input type='submit' />
		</div>
	</Form>
)
