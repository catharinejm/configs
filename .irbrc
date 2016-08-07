require 'irb/completion'

IRB.conf[:IRB_RC] = proc do |conf|
  name = "irb(#{RUBY_VERSION}): "
  name = "rails(#{Rails.version}, ruby #{RUBY_VERSION}): " if defined?(Rails)
  leader = " " * (name.length - 3)
  conf.prompt_i = "#{name}"
  conf.prompt_s = leader + '?> '
  conf.prompt_c = leader + '?> '
  conf.prompt_n = leader + '?> '
  conf.auto_indent_mode = true
  conf.return_format = ('=' * (name.length - 2)) + "> %s\n"
end

IRB_HISTORY_FILE = "~/.irb_history_#{RUBY_PLATFORM}_#{RUBY_VERSION}"
IRB_HISTORY_MAXIMUM_SIZE = 500

begin
  histfile = File::expand_path(IRB_HISTORY_FILE)
  
  if File::exists?(histfile)
    lines = IO::readlines(histfile).collect { |line| line.chomp }
    Readline::HISTORY.push(*lines)
  end
  
  Kernel::at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines.reject! { |line| line == 'exit' }
    lines = lines[-IRB_HISTORY_MAXIMUM_SIZE, IRB_HISTORY_MAXIMUM_SIZE] if lines.compact.size > IRB_HISTORY_MAXIMUM_SIZE
    File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
  end
end

def m(o)
  case o
  when Module
    (o.methods - Module.methods).sort
  else
    (o.methods - Object.instance_methods).sort
  end
end
