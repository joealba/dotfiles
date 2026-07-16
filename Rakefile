require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE].include? file
    next if file =~ /\.bak$/
    
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "symlink agents/skills into ~/.claude/skills and ~/.codex/skills"
task :install_skills do
  skills_source = File.join(Dir.pwd, 'agents', 'skills')

  ['.claude', '.codex'].each do |tool_dir|
    dest_root = File.join(ENV['HOME'], tool_dir, 'skills')
    system %Q{mkdir -p "#{dest_root}"}

    Dir[File.join(skills_source, '*')].each do |skill_path|
      name = File.basename(skill_path)
      destination = File.join(dest_root, name)

      if File.symlink?(destination)
        if File.readlink(destination) == skill_path
          puts "identical #{tool_dir}/skills/#{name}"
        else
          system %Q{rm "#{destination}"}
          system %Q{ln -s "#{skill_path}" "#{destination}"}
          puts "relinking #{tool_dir}/skills/#{name}"
        end
      elsif File.exist?(destination)
        print "overwrite #{tool_dir}/skills/#{name}? [yn] "
        if $stdin.gets.chomp == 'y'
          system %Q{rm -rf "#{destination}"}
          system %Q{ln -s "#{skill_path}" "#{destination}"}
          puts "linking #{tool_dir}/skills/#{name}"
        else
          puts "skipping #{tool_dir}/skills/#{name}"
        end
      else
        system %Q{ln -s "#{skill_path}" "#{destination}"}
        puts "linking #{tool_dir}/skills/#{name}"
      end
    end
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    destination = file =~ /\Abin\z/ ? file : ".#{file}"
    puts "linking ~/#{destination}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/#{destination}"}
  end
end
