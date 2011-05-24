require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mortimer::Core do
  def new_mortimer
    @mort = Mortimer::Core.new('/tmp', '/tmp')
  end

  attributes = %w(input_dir output_dir)

  describe "attributes" do
    attributes.each do |item|
      before do
        @mort = new_mortimer
      end

      subject { @mort }
      it { should respond_to item.to_sym }
    end
  end

  describe "validation" do
    before(:each) do
      @mort = new_mortimer
    end

    describe "verifies essential attributes" do
      attributes.each do |item|
        it "verifies #{item} is specified or raises an exception" do
          pending
        end
      end
    end

    describe "verifies valid directory" do
      attributes.each do |item|
        pending
      end
    end
  end

  describe "processing" do
  end
end
