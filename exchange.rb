#!/usr/bin/env ruby

# exchanges files between two computers through an intermediary server
#
# files are kept on the server in the ~/.exchange directory
#
# if you need to get/put a file that is a reserved word, prefix with ./ or some
# other path

# your server here
SERVER = 'manko'

def run(command)
  puts command
  exec command
end

def quoted_list(args)
  args.collect { |arg| '"%s"' % arg }.join(" ")
end

case ARGV.first
when 'install'
  run('ssh %s mkdir .exchange' % SERVER)
when 'clear'
  run('ssh %s rm -i ".exchange/*"' % SERVER)
when 'get'
  ARGV.shift
  args = (ARGV.empty? ? '*' : ARGV).collect { |arg| '%s:.exchange/%s' % [SERVER, arg] }
  puts args.inspect
  run('scp -r %s .' % quoted_list(args))
when 'ls'
  run('ssh %s ls -l .exchange/' % SERVER)
when nil
  usage = <<EOF
  %s ls             list files in .exchange dir on server
  %s get            copy all files in remote .exchange dir to current dir
  %s get file1 ...  copy files in remote .exchange dir to current dir
  %s file1 ...      copy file1, file2, etc. to remote .exchange dir  
  %s clear          interactively delete contents of .exchange dir
  %s install        create .exchange dir on server
EOF
  puts usage.gsub('%s', File.basename($0))
  exit 1
else
  run('scp -r ' + quoted_list(ARGV) + ' %s:.exchange/' % SERVER)
end
