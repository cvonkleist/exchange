## About

I created this because sometimes I need to exchange a file or two between my
home and work computers (the latter is a two-step SSH through my employer's
gateway machine). I can accomplish this several ways:

1. Use SSH connection forwarding trickery (not too hard) and using `scp` a lot
   (a pain)
2. Copy files through an intermediary which is not behind any firewall (my web
   server) using `scp` a lot (also a pain)
3. Copy files through an intermediary using a script that automates the process *(winner!)*

This project is the script described in step 3.

## Usage

Stick this in your `~/bin` directory -- everyone has something like `~/bin` in his path, right? -- and make it executable. Then, use it like this:

    # create .exchange dir on server (first time use only)
    $ exchange.rb install

    # send file foo to server (run on one machine)
    $ exchange.rb foo

    # list files, then retrieve file foo (run on other machine)
    $ exchange.rb ls
    total 8
    -rw-r--r-- 1 cvk cvk  684 Oct 20 22:23 README.markdown
    -rw-r--r-- 1 cvk cvk 1200 Oct 20 22:39 exchange.rb
    -rw-r--r-- 1 cvk cvk   42 Oct 20 22:01 foo
    $ exchange.rb get foo

Run exchange with no arguments to get this handy usage message:

    exchange.rb ls             list files in .exchange dir on server
    exchange.rb get            copy all files in remote .exchange dir to current dir
    exchange.rb get file1 ...  copy files in remote .exchange dir to current dir
    exchange.rb file1 ...      copy file1, file2, etc. to remote .exchange dir  
    exchange.rb clear          interactively delete contents of .exchange dir
    exchange.rb install        create .exchange dir on server
