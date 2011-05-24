module Mortimer
  class Core
    require "maruku"

    attr_accessor :input_dir, :output_dir, :errors

    def initialize (input_dir, output_dir)
      @input_dir  = input_dir
      @output_dir = output_dir
      @errors     = Array.new
    end

    def valid?
      [:input_dir, :output.dir].each do |attr|
        if self.send(attr).empty?
          errors.push [ attr.to_s, "no value specified" ]
        else
          # Make sure the directory exists
          if File.directory? self.send(attr)
            errors.push [ attr.to_s, "Directory doesn't exist" ]
          end
        end
      end

      if !errors.empty?
        return false
      end

      return true
    end
  end
end
