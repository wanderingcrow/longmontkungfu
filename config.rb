require 'slim'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload do |live|
    # live.livereload_css_target = "assets/stylesheets/all.css"
    live.livereload_css_pattern = Regexp.new('_.*\.sass')
  end
end

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

# automagically add alt tags to images
activate :automatic_alt_tags

# contentful info
activate :contentful do |f|
  f.space = { greatway: 'bdllfbg9npjz' }
  f.access_token = 'f0ddf42524660964b82f706c430867b7f72ce8ba46525da61892ab53537e2f55'
  f.cda_query = { limit: 1000 }
  f.content_types = {
    testimonial: '4zvUlYLQSAyMqSi4Ugka2q',
    events: '6qhjP37bZCKImkYqKmYkYu',
    staff: 'staff',
    classSchedule: 'classSchedule',
  }
end

# using markdown for contentful stuff
set :markdown_engine, :kramdown

# seo goodness
page "/sitemap.xml", :layout => false

set :default_title, 'Great Way Chinese Martial Arts'
set :default_meta_description, 'Great Way trains our students mentally, physically, and spiritaully — it is not just self-defense, but a way of life.'
set :default_meta_image, 'http://greatwaychinesemartialarts.com/assets/images/default-og-image.jpg'
set :default_meta_keywords, 'Martial Arts, Kung Fu, Tai Chi, Chinese Medicine, self defense, stop bullying, confidence, Longmont, Colorado, Boulder, Frederick, Firestone, Niwot'
