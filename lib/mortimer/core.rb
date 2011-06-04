module Mortimer
  class Core
    require "maruku"
    require "fileutils"

    attr_accessor :input_dir, :output_dir, :header, :footer

    def initialize (input_dir, output_dir)
      @input_dir  = input_dir
      @output_dir = output_dir

      validate_directories
    end

    def process
      # Read header and footer files

      # Copy CSS from input directory to output directory, if it exists
        # If not, we might want to raise a warning here

      # Run through the input directory and process any Markdown files

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
      end

      if !@input_dir.empty? && !Dir.exists?(@input_dir)
        err_msg = "input_dir directory does not exist: #{@input_dir}"
        errors.push err_msg
      end

      # If the output directory isn't empty and it doesn't exist, attempt to
      # create it

      if !@input_dir.empty? && !Dir.exists?(@output_dir)
        begin
          FileUtils.mkdir_p(@output_dir)
        rescue Exception => e
          errors.push "Could not create directory: #{e.to_s}"
        end
      end

      if !errors.empty?
        error_msg = errors.join("\n")

        raise Exception, error_msg
      end
    end
  end
end
