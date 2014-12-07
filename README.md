## Twirly

[![Gem version](https://badge.fury.io/rb/twirly.png)](http://badge.fury.io/rb/twirly)

Twirly is a cli tool which converts [Trello](http://trello.com) cards to
articles for use with ruby static site generators like 
[middleman](http://middlemanapp.com/), [jekyll](http://jekyllrb.com/), [nanoc](http://nanoc.ws/)

## Usage

Add it to the `Gemfile` of the static site project.

`gem 'twirly'`

For a list of available commands run `twirly help`
For help on a command run `twirly help some_command`

## Setup

It requires a `twirly.yml` file to be present in the project root.

Example:

```yaml
trello_key: 'deadc2592ce753b3bad'
trello_secret: 'deaddc5712771bad'
organization: 'some_organization'
publishing_board: 'iPAnh67A'
```

## Pull

Convert all cards having a 'published' label to articles

`twirly pull`

## Pick

Convert a specific card (identified by short_id) to article

`twirly pick`

## Fetch User

Create a page for a board user

`twirly fetch_user zorbash`

# Author

[zorbash](https://github.com/zorbash)

# Licence
Released under the MIT License. See the
[LICENSE](https://github.com/Zorbash/twirly/blob/master/LICENSE) file
for further details.
