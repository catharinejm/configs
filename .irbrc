script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

require 'pp'
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:VERBOSE] = true

begin
  require 'rubygems'
  require 'wirble'

  Wirble.init     

  colors = Wirble::Colorize.colors.merge({
    # delimiter colors
    :comma              => :white,
    :refers             => :white,

    # container colors (hash and array)
    :open_hash          => :white,
    :close_hash         => :white,
    :open_array         => :white,
    :close_array        => :white,

    # object colors
    :open_object        => :cyan,
    :object_class       => :purple,
    :object_addr_prefix => :cyan,
    :object_addr        => :light_red,
    :object_line_prefix => :cyan,
    :object_line        => :yellow,
    :close_object       => :cyan,

    # symbol colors
    :symbol             => :blue,
    :symbol_prefix      => :blue,

    # string colors
    :open_string        => :green,
    :string             => :green,
    :close_string       => :green,

    # misc colors
    :number             => :blue,
    :keyword            => :blue,
    :class              => :purple,
    :range              => :white
  })                                     
  Wirble::Colorize.colors = colors                                              
  Wirble.colorize
  
  rvm_ruby_string = 
    ENV["rvm_ruby_string"] || 
      "#{RUBY_ENGINE rescue 'ruby'}-#{RUBY_VERSION}-#{(RUBY_PATCHLEVEL) \
        ? "p#{RUBY_PATCHLEVEL}"                                         \
        : "r#{RUBY_REVISION}"}"
  # colorize prompt
  IRB.conf[:PROMPT][:CUSTOM] = {
    :PROMPT_I =>    Wirble::Colorize.colorize_string("(#{rvm_ruby_string}) >> ", :cyan),
    :PROMPT_S =>    Wirble::Colorize.colorize_string("(#{rvm_ruby_string}) >> ", :green),
    :PROMPT_C => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
    :PROMPT_N => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
    :RETURN   => "#{Wirble::Colorize.colorize_string('>'  , :light_red)} %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :CUSTOM
rescue 
    IRB.conf[:PROMPT][:spicycode] = {
      :PROMPT_I=> "irb >> ", 
      :PROMPT_N=> "irb >> ", 
      :PROMPT_S=> nil, 
      :PROMPT_C=> "irb ?> ", 
      :RETURN=> "irb \=> %s\n"
    }

    IRB.conf[:PROMPT][:DEFAULT].replace(IRB.conf[:PROMPT][:spicycode])
    IRB.conf[:PROMPT_MODE] = :spicycode
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
