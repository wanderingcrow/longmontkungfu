# Read Me

## About the project.

This project uses the fantastic [Middleman](https://middlemanapp.com) for the layout and many static pages, and [Contentful](https://www.contentful.com) to handle the content.

----

## Installation

Assumes you have a rails dev environment and bundler installed.

1. Clone and cd into folder
2. `bundle install`
3. Create a `.env` file at the root of the project and supply the API token for Contentful.
4. `middleman contentful` will popluate or update your data folder. All data is ignored in git.

----

## Usage

### Modals
Modals use [Remodal](https://github.com/VodkaBears/Remodal). To use, give the modal a class of `remodal` and `data-remodal-id='modal'`. `button.remodal-close(data-remodal-action='close')` is your close button. The modal itself is simply called with a hashtag.
