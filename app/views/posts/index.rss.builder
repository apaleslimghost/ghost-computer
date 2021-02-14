xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
   xml.channel do
     xml.title "a pale slim ghost"
     xml.description "is Kara Brightwell"
     xml.link root_url

     @posts.each do |post|
       xml.item do
         xml.title post.title
         xml.description do
            xml.cdata! post.html_body
         end
         xml.pubDate post.posted.to_s(:rfc822)
         xml.link post_url(post)
         xml.guid post_url(post)
       end
     end
   end
 end
