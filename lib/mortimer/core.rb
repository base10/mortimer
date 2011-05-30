module Mortimer
  class Core
    require "maruku"

    attr_accessor :input_dir, :output_dir

    def initialize (input_dir, output_dir)
      @input_dir  = input_dir
      @output_dir = output_dir

      validate_directories
    end

    def process


    end

    protected

    def validate_directories
      errors = Array.new

      ['input_dir', 'output_dir'].each do |method|
        path = send(method)

        if path.empty?
          err_msg = "Required argument #{method} not specified"
          errors.push err_msg
        end

        if !path.empty? && !Dir.exists?(path)
          err_msg = "#{method} directory does not exist: #{path}"
          errors.push err_msg
        end
      end

      if !errors.empty?
        error_msg = errors.join("\n")

        raise Exception, error_msg
      end
    end
  end
end
