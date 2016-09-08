# Read Me

## About the project.

This project uses the fantastic [Middleman](https://middlemanapp.com) for the layout and many static pages, and [Contentful](https://www.contentful.com) to handle the content.

----

## Installation

Assumes you have bundler installed.

1. Clone and cd into folder
2. `bundle install`
3. Create a `.env` file at the root of the project and supply the API token for Contentful.
4. `middleman contentful` will popluate or update your data folder. All data is ignored in git.

----

## Misc Info

### External Assets

- s3.amazonaws.com/wfp-external-assets/

### Facebook Sharing Images

Facebook (and other social media) will often grab the first image in your page. If this isn't what you want, you need to specify an 'ogimage'. For Facebook at least, the size of this image should be 1200x630. You'll want to specify the image in the front matter.

Example: `ogImage: "https://www.waterforpeople.org/assets/images/25th-anniv/fb-image.jpg"`

If the wrong image is cached (it happens), use FBs linter:
- https://developers.facebook.com/tools/debug/og/object/
- https://developers.facebook.com/docs/sharing/webmasters

### Stylesheets
You can find a somewhat organized list of the styles guide [here](https://www.waterforpeople.org/styles-guide).
### Preview API
Contentful comes with a preview API. This allows you to preview content before it's published. The way that this works is that we have another server which shows all 'draft' content. The server is setup via Netlify and uses two important variables.
1. CONTENTFUL_TOKEN = (use the preview API in Contentful)
1. PREVIEW_TOGGLE = true

[Preview Server](http://green-tea-preview.netlify.com/)
