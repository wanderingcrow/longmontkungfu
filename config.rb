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
  f.space = { greatway: 'bdllfbg9npjz' }
  f.access_token = ENV['CONTENTFUL_TOKEN']
  f.cda_query = { limit: 10000 }
  f.content_types = {
    testimonial: '4zvUlYLQSAyMqSi4Ugka2q',
    schedule: '7M3YEMOiDSYMoQWqMYAmEc',
    snippets: '2vxx6oWPpuiEyoQyYQKYUg',
    snippetsLong: '43iBGgebSgYgKWEaW44KYG',
    events: '6qhjP37bZCKImkYqKmYkYu',
  }
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
