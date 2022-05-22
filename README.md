# Tram

Tram is a static website generator using Slim & Sass.
It provides a server to develop static websites while converting Slim and Sass into HTML and CSS.

## Installation

```shell
$ gem install tram
```

## Usage

Start a new website project with the following commands.

```shell
$ tram new mysite
$ cd mysite
```

You can start development by starting the server with the following command.

```shell
$ tram s
$ open http://localhost:5000
```

Slim and Sass to be developed, and the output HTML and CSS are located in the following directories.

```
$ % ls -l
drwxr-xr-x  5 rinkei  rinkei  160  5 22 08:56 output
drwxr-xr-x  3 rinkei  rinkei   96  5 22 08:56 sass
drwxr-xr-x  3 rinkei  rinkei   96  5 22 08:57 slim
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tram project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rinkei/tram/blob/master/CODE_OF_CONDUCT.md).
