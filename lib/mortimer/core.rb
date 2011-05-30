module Mortimer
  class Core
    require "maruku"

    attr_accessor :input_dir, :output_dir

    def initialize (input_dir, output_dir)
      @input_dir  = input_dir
      @output_dir = output_dir

      @errors     = Array.new

      validate_directories
    end

    protected

    def validate_directories
      errors = Array.new

      [@input_dir, @output_dir].each do |path|
        if !Dir.exists?(path)
          err_msg = { "#{path}" => "Directory does not exist" }
          errors.push( err_msg )
        end
      end

      if !errors.empty?
        raise Exception
      end
    end
  end
end
