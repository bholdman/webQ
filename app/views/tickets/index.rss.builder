xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link tickets_url

    for ticket in @tickets
      xml.item do
        xml.subject ticket.subject
        xml.description ticket.body
        xml.pubDate ticket.created_at.to_s(:rfc822)
      end
    end
  end
end