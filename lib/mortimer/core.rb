module Mortimer
  class Core
    require "maruku"

    attr_accessor :input_dir, :output_dir

    def initialize (input_dir, output_dir)
      @input_dir  = input_dir
      @output_dir = output_dir

      validate_directories
    end

    protected

    def validate_directories
      errors = Array.new

      [@input_dir, @output_dir].each do |path|
        if !Dir.exists?(path)
          err_msg = "#{path} - Directory does not exist"
          errors.push( err_msg )
        end
      end

      if !errors.empty?
        error_msg = errors.join("\n")

        raise Exception, error_msg
      end
    end
  end
end
