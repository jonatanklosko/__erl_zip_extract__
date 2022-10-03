-module(zip_extract_test).

-export([main/1]).

main(_Argv) ->
  application:ensure_all_started(inets),
  application:ensure_all_started(ssl),

  file:del_dir_r("tmp"),
  file:make_dir("tmp"),

  io:format("Downloading the archive~n"),
  Url = "https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-portable-Q16-x64.zip",
  {ok, {{_, 200, _}, _, Body}} = httpc:request(get, {Url, []}, [], []),

  io:format("Unzipping~n"),
  file:write_file("tmp/ImageMagick-7.1.0-portable-Q16-x64.zip", Body),
  {ok, _Paths} = zip:extract("tmp/ImageMagick-7.1.0-portable-Q16-x64.zip", [{cwd, "tmp/extract"}]).
