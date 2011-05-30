require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mortimer::Core do
  def new_mortimer
    mort = Mortimer::Core.new('/tmp', '/tmp')
    return mort
  end

  attributes = %w(input_dir output_dir)

  describe "attributes" do
    before do
      @mort = new_mortimer
    end

    attributes.each do |method|
      subject { @mort }
      it { should respond_to method }
    end
  end

  describe "#initialize -- object instantiation" do
    context "passes" do
      before(:each) do
        @mort = new_mortimer
      end

      it "when given input and output directories" do
        Dir.stub!(:exists?).and_return(true)
        lambda { Mortimer::Core.new('/foo', '/bar') }.should_not raise_error
      end

      attributes.each do |method|
        it "#{method} should be set" do
          @mort.send(method).should_not be_empty
        end
      end
    end

    context "fails" do
      specify "without input or output directories" do
        expect { Mortimer::Core.new }.to raise_error
        expect { Mortimer::Core.new('', '/tmp') }.to raise_error(/not specified/)
        expect { Mortimer::Core.new('/tmp', '') }.to raise_error(/not specified/)
      end

      context "when missing valid" do
        before(:each) do
          Dir.should_receive(:exists?).with('/foo').and_return(false)
          Dir.should_receive(:exists?).with('/tmp').and_return(true)
        end

        specify "input directory" do
          expect { Mortimer::Core.new('/foo', '/tmp') }.to raise_error(/does not exist/)
        end

        specify "output directory" do
          expect { Mortimer::Core.new('/tmp', '/foo') }.to raise_error(/does not exist/)
        end
      end
    end
  end

  describe "#process -- Getting Morimer to convert Markdown to HTML" do
  end
end
