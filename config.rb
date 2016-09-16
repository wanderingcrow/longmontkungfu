require 'slim'


# the middleman-livereload extension isn't doing live style injection,
# using http://livereload.com/ instead

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload do |live|
#     live.livereload_css_target = "assets/stylesheets/all.css"
#   end
# end

# Directories
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# rebuild redirects for Netlify
after_build do |builder|
  src = File.join(config[:source],"_redirects")
  dst = File.join(config[:build_dir],"_redirects")
  builder.thor.source_paths << File.dirname(__FILE__)
  builder.thor.copy_file(src,dst)
end

# pretty URLs
activate :directory_indexes

# hide private keys
activate :dotenv

# automagically add alt tags to images
activate :automatic_alt_tags

# contentful info
activate :contentful do |f|
  f.space = { wfp: 'aabtv568laap' }
  f.access_token = ENV['CONTENTFUL_TOKEN']
  if f.use_preview_api = 'true'
    f.use_preview_api = ENV['PREVIEW_TOGGLE']
  end
  f.cda_query = { limit: 10000 }
  f.content_types = {
    blog: '4GLrYgsCHeuGe084OQUskK',
    boardMembers: 'boardMembers',
    careers: '5h1ALECD6My2qCsO4wQ0CK',
    countryPages: '5W5k7zxImkY80mmYQmYsyM',
    highlights: 'highlights',
    intlNews: '5SiKEp6j0AAoyOmcG0WE8Q',
    intlStaff: '2OCsCR9ueQQaCw2iKAueaS',
    news: '5sjvvM0PleAcSe6IOskmSA',
    sectorNews: 'sectorNews',
    sponsors: 'sponsors',
    stories: 'stories',
    team: 'team',
  }
end

if Dir.exist?(config.data_dir)

  data.wfp.careers.each do |careers|
    proxy "about/#{ careers[1][:slug] }.html", "about/post.html", :ignore => true, :layout => 'layout', :locals => { careers: OpenStruct.new(careers[1]) }
  end

  data.wfp.stories.each do |stories|
    proxy "stories/#{ stories[1][:slug] }.html", "stories/story.html", :layout => 'layout', :locals => { stories: OpenStruct.new(stories[1]) }, :ignore => true
  end

  data.wfp.sectorNews.each do |sectorNews|
    proxy "stories/#{ sectorNews[1][:slug] }.html", "stories/snPost.html", :ignore => true, :layout => 'layout', :locals => { sectorNews: OpenStruct.new(sectorNews[1]) }
  end

  data.wfp.countryPages.each do |countryPages|
    proxy "country-pages/#{ countryPages[1][:slug] }.html", "country-pages/country-page.html", :ignore => true, :layout => 'naked', :locals => { countryPages: OpenStruct.new(countryPages[1]) }
  end

  data.wfp.news.each do |news|
    proxy "media/#{ news[1][:slug] }.html", "media/post.html", :ignore => true, :layout => 'layout', :locals => { news: OpenStruct.new(news[1]) }
  end

end

# build is borking on Netlify, bandaid
ignore "about/post.html"
ignore "stories/story.html"
ignore "stories/snPost.html"
ignore "country-pages/country-page.html"
ignore "media/post.html"

# using markdown for contentful stuff
set :markdown_engine, :kramdown

# seo goodness
page "/sitemap.xml", :layout => false
