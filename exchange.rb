#!/usr/bin/env ruby

# exchanges files between two computers through an intermediary server
#
# files are kept on the server in the ~/.exchange directory

SERVER = 'manko'

def run(command)
  puts command
  exec command
end

case ARGV.first
when 'clear'
  run('ssh %s rm -i ".exchange/*"' % SERVER)
when 'get'
  run('scp -r %s:.exchange/* .' % SERVER)
when 'ls'
  run('ssh %s ls -l .exchange/' % SERVER)
when nil
  usage = <<EOF
  %s ls          list files
  %s clear       interactively delete .exchange dir
  %s get         copy files in remote .exchange dir to current dir
  %s file1 ...   copy file1, file2, etc. to remote exchange dir  
EOF
  puts usage.gsub('%s', $0)
  exit 1
else
  run('scp -r ' + ARGV.collect { |c| '"%s"' % c }.join(" ") + ' %s:.exchange/' % SERVER)
end
