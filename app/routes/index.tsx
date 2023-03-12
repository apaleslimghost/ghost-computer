import { typedjson, useTypedLoaderData } from 'remix-typedjson'
import { Post } from "~/components/post/post"
import db from "~/lib/db.server"

export const handle = {
  navContent: {
    className: 'home',
    children: <section>
      she'll haunt you with:
      <ul>
        <li>
          <a href="https://open.spotify.com/artist/3TzsOJwiMZHmnnRFAdfuUH?si=FJp1sgIJQ4GX8ZHOArHH0g" target="blank" rel="noopener">big kicks & rich noises</a>
        </li>
        <li>
          <a href="https://www.youtube.com/channel/UCuwdW47KpcunIOlFaB63KbQ" target="blank" rel="noopener">live performed bullshit noise</a>
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
  const posts = await db.posts.findMany({
    orderBy: {
      posted: 'desc'
    }
  })

  return typedjson({ posts })
}

export default function Index() {
  const { posts } = useTypedLoaderData<typeof loader>()

  return <>
    {posts.map(post => <Post key={post.id.toString()} post={post} />)}
  </>
}
