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

      specify "when given input and output directories" do
        Dir.stub!(:exists?).and_return(true)
        lambda { Mortimer::Core.new('/foo', '/bar') }.should_not raise_error
      end

      attributes.each do |method|
        it "#{method} should be set" do
          @mort.send(method).should_not be_empty
        end
      end

      it "creates missing output directory if needed" do
        Dir.should_receive(:exists?).with('/foo').and_return(false)
        Dir.should_receive(:exists?).with('/tmp').and_return(true)
        Dir.should_receive(:mkdir).with('/foo').and_return(true)

        expect { Mortimer::Core.new('/tmp', '/foo') }.to_not raise_error
      end
    end

    context "fails" do
      specify "without input or output directories" do
        expect { Mortimer::Core.new }.to raise_error
        expect { Mortimer::Core.new('', '/tmp') }.to raise_error(/not specified/)
        expect { Mortimer::Core.new('/tmp', '') }.to raise_error(/not specified/)
      end

      specify "when missing valid input directory" do
        Dir.should_receive(:exists?).with('/foo').and_return(false)
        Dir.should_receive(:exists?).with('/tmp').and_return(true)

        expect { Mortimer::Core.new('/foo', '/tmp') }.to raise_error(/does not exist/)
      end

      specify "when output directory can't be created" do
        Dir.should_receive(:exists?).with('/foo').and_return(false)
        Dir.should_receive(:exists?).with('/tmp').and_return(true)
        Dir.stub!(:mkdir).and_raise(Errno::EACCES)

        expect { Mortimer::Core.new('/tmp', '/foo') }.to raise_error(/Could not create directory/)
      end
    end
  end

  describe "#process -- Getting Morimer to convert Markdown to HTML" do
    before(:each) do
      # Ensure the test output directory is empty

      # Instantiate a new object with the test_input and test_output directories
    end

    context "header and footer processing" do

    end

    context "CSS processing" do

    end

    context "Markdown file processing" do

    end
  end
end
