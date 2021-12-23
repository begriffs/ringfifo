## Nonblocking multi-use named pipes

Ringfifo manages two named pipes to create a virtual fifo. As long as the
program is running, writers are never blocked, and readers never get an EOF.

```sh
# create foo.in, foo.out and wait for data
$ ringfifo foo &

# echo returns right away
$ echo hi > foo.in

# empties buffer, waits for more
$ cat foo.out
hi
```

In that example, you can pipe more data to `foo.in` and `cat` will continue to
print it. If you terminate `cat`, then `ringfifo` will again queue incoming
lines for later.

The program has a configurable internal line limit, at which point it'll drop
old lines from the buffer to make room for new lines.

### Usage

```
ringfifo fifo-name [max-lines]
```

* `fifo-name` base name of the virtual fifo. Creates named pipes `fifo-name.in`
  and `fifo-name.out`.
* `max-lines` line limit of the internal ring buffer. Default 8192.

Each buffered line is currently limited to `BUFSIZ` characters. I haven't taken
the time to make that configurable, but it's an easy change.

### Building

Requires POSIX and [libderp](https://github.com/begriffs/libderp) 0.1.0.
Install libderp, and run `make`. The library will be statically linked into the
executable.
