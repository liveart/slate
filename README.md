
<p align="center">LiveArt API Documentation (using Slate).</p>

Rebuilding / publishing
------------------------------

### Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 2.2.5 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.

### Getting Set Up

1. Clone this repository.
2. Initialize and start Slate. You can either do this locally, or with Vagrant:

```shell
# either run this to run locally
bundle install
bundle exec middleman build
bundle exec middleman server
```

3. Once you've checked and happy with result, you can deploy with
```shell
./deploy.sh
```
