# RTram

RTram is a static website generator using Slim & Sass.
It provides a server to develop static websites while converting Slim and Sass into HTML and CSS.

## Installation

```shell
$ gem install rtram
```

## Usage

Start a new website project with the following commands.

```shell
$ rtram new mysite
$ cd mysite
```

You can start development by starting the server with the following command.

```shell
$ rtram s
$ open http://localhost:5000
```

Then `.slim` files in `slim` directory and `.sass` or `.scss` files in `sass` directory are converted during the server is working.

The output HTML and CSS files are generated in `output` directory.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RTram project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rinkei/rtram/blob/master/CODE_OF_CONDUCT.md).
