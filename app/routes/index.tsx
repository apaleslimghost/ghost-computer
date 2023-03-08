
export const handle = {
  navContent: <section>
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
        <a href="https://mastodon.social/apaleslimghost" target="blank" rel="me noopener">shitposts</a>
      </li>
    </ul>
  </section>
}

export default function Index() {
  return (
    <div style={{ fontFamily: "system-ui, sans-serif", lineHeight: "1.4" }}>
      <h1>Welcome to Remix</h1>
      <ul>
        <li>
          <a
            target="_blank"
            href="https://remix.run/tutorials/blog"
            rel="noreferrer"
          >
            15m Quickstart Blog Tutorial
          </a>
        </li>
        <li>
          <a
            target="_blank"
            href="https://remix.run/tutorials/jokes"
            rel="noreferrer"
          >
            Deep Dive Jokes App Tutorial
          </a>
        </li>
        <li>
          <a target="_blank" href="https://remix.run/docs" rel="noreferrer">
            Remix Docs
          </a>
        </li>
      </ul>
    </div>
  );
}
