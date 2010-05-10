require 'irb/completion'

script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

IRB.conf[:IRB_RC] = proc do |conf|
  name = "irb(#{RUBY_VERSION}): "
  name = "rails: " if $0 == 'irb' && ENV['RAILS_ENV'] 
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
