require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mortimer::Core do
  def new_mortimer
    @mort = Mortimer::Core.new('/tmp', '/tmp')
  end

  attributes = %w(input_dir output_dir)

  describe "attributes" do
    before do
      @mort = new_mortimer
    end

    attributes.each do |item|
      subject { @mort }
      it { should respond_to item.to_sym }
    end
  end

  describe "#initialize" do
    context "passes" do
      it "when given input and output directories" do
        Dir.stub!(:exists?).and_return(true)
        lambda { Mortimer::Core.new('/foo', '/bar') }.should_not raise_error
      end
    end

    context "fails" do
      specify "without input or output directories" do
        expect { Mortimer::Core.new }.to raise_error
      end

      context "when missing valid" do
        before(:each) do
          Dir.should_receive(:exists?).with('/foo').and_return(false)
        end

        specify "input directory" do
          expect { Mortimer::Core.new('/foo', '/tmp') }.to raise_error
        end

        specify "output directory" do
          expect { Mortimer::Core.new('/tmp', '/foo') }.to raise_error
        end
      end

      specify "" do
        pending
      end
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
