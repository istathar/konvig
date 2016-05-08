NOTES ON THE COMPACT FORMAT
=====

Bare keys
---------

```
message = Hello World
```

Using ini style ` = ` as separator between keys and values works, but in
practice there's no ambiguity between key and value; even in RFC 822 style
headers it's not like there are any header fields with space characters in
them.

Dropping the equals, however, makes bare strings less appealing.

```
message Hello World
```

Which has brought me back to 

```
message "Hello World"
```

The obvious downside is that interior double quote characters need backslash
escaping. But it visually emphasizes that this is a _string_ and any
interpretation within that is up to the consuming program.

Multiline strings
-----------------

Earlier designs presented the notion of using here documents, and even trialed
the here document syntax from the shell.

```
multi = <<HERE
This is a test of the Emergency Broadcast System.
If it wasn't a test, you'd never know anyway.>
HERE
```

There were a few things unsatisfying about this. The equals is redundant (one
of the things that brought me to ditch them) and the double less than is
clumsy.

That made me reflect to the notion of a block, and indeed the uniform notion
throughout modern programming for a block is braces. So in compact form,

```
multi {
This is a test of the Emergency Broadcast System.
If it wasn't a test, you'd never know anyway.
}
```

Interior characters parsed literally, no escaping. Obvious problem with that
is when you've got program code internally, so combine idea with here
document / multipart mime syntax:


```
multi {HERE
This is a test of the Emergency Broadcast System.
If it wasn't a test, you'd never know anyway.
HERE}
```
or
```
multi {2oijgWWEFa
This is a test of the Emergency Broadcast System.
If it wasn't a test, you'd never know anyway.
2oijgWWEFa}
```

Which is nicely flexible. It's not hard to find a sequence; `-}` may be
significant in Haskell but not in C and its descendants. `*}` isn't going to
turn up in Haskell either.

```
programInC {-
/*
 * program entry point
 */
int main(int* argc, char** argv) {
         printf("Hello World\n");
         return 0;
}
-}

programInHaskell {*

data Foo = Bar {
    frock :: String,
    galosh :: Int
}

--
-- program entry point
--
main :: IO ()
main = do
    putStrLn "Hello World"
*}

```

doesn't matter what symbol you use; they're here documents. Personally I think
output writers should go for random strings of length 6 or so.

```
multi {2oijgWa
This is a test of the Emergency Broadcast System.
If it wasn't a test, you'd never know anyway.
2oijgWa}
```

URLs
----

```
homepage <http://www.example.com>
```

It's not a special type so much as an alternate delimiter for fields
containing universal resource locators. URLs show up in data a *lot*.

Lists
-----

One of the things that caused me to ignore the `[[ ... ]]` delimiter for
multiline strings used by Lua is that `[` is unavoidable as introducing a
syntactic list. Which is why Haskell's quasi quoter syntax `[| ... |]` is out
too.

Having settled on `{ ... }` as a multiline block, bracket is free again. And
meanwhile the bad taste in my mouth from Java's properties files attempt at
lists remains sour a decade later. So why not support lists naively, even if
at present I don't have a serious use case for them? Sure.

```
seasons ["winter", "road construction"]
```

which is one of the reasons quotes were worth restoring.

