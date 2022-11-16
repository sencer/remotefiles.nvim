# remotefiles.nvim

This is a lightweight plugin to read & write files over scp.

Read/write handlers for other files can also be registered using:

```
require("remotefiles").register(
  pattern,
  read_handler_fn,
  write_handler_fn
)
```

`pattern` is required and it is passed to autocmd.

`read_handler_fn` is required. It accepts a single argument, filename, and
prints the file contents to stdout.

`write_handler_fn` is optional. It accepts a single argument, filename; reads
file contents from stdin and writes it to the file. If it is not provided, the
file will be `readonly`.

For an example, see `plugin/remotefiles.lua`.
