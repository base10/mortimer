require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mortimer do
  attributes = %w(input_dir output_dir)

  describe "attributes" do
    attributes.each do |item|
      it "should include a #{item}"
    end
  end

  describe "validation" do
    attributes.each do |item|
      it "verifies #{item} is specified or raises an exception"
    end

    attributes.each do |item|
      it "checks #{item}'s value as a valid directory"
    end
  end

  describe "processing" do

  end
end
