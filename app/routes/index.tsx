import { typedjson, useTypedLoaderData } from 'remix-typedjson'
import { PostView } from "~/components/post/post"
import db from "~/lib/db.server"

export const handle = {
  navContent: {
    className: 'home',
    children: <section>
      she'll haunt you with:
      <ul>
        <li>
          <a href="https://asmpts.com" target="blank" rel="noopener">big kicks & rich noises</a>
        </li>
        <li>
          <a href="https://paleslimghost.store" target="blank" rel="noopener">synthesisers and synthesiser accessories</a>
        </li>
        <li>
          <a href="https://github.com/apaleslimghost" target="blank" rel="noopener">error messages that tell you how they can be fixed</a>
        </li>
        <li>
          <a href="https://cathode.church/@apaleslimghost" target="blank" rel="me noopener">shitposts</a>
        </li>
      </ul>
    </section>,
  }
}

export async function loader() {
  const posts = await db.post.findMany({
    orderBy: {
      createdAt: 'desc'
    }
  })

  return typedjson({ posts })
}

export default function Index() {
  const { posts } = useTypedLoaderData<typeof loader>()

  return <>
    {posts.map(post => <PostView key={post.id.toString()} post={post} />)}
  </>
}
