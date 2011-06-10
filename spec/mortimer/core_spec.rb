require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mortimer::Core do
  def new_mortimer
    mort = Mortimer::Core.new('/tmp', '/tmp')
    return mort
  end

  init_attributes = %w(input_dir output_dir)
  attributes = init_attributes + %w(header footer)

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

      init_attributes.each do |method|
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
        FileUtils.stub!(:mkdir_p).and_raise(Errno::EACCES)

        expect { Mortimer::Core.new('/tmp', '/foo') }.to raise_error(/Could not create directory/)
      end
    end
  end

  describe "#process -- Getting Morimer to convert Markdown to HTML" do
    before(:each) do
      @input_dir   = File.expand_path(File.dirname(__FILE__) + "/../test_input")
      @output_dir  = File.expand_path(File.dirname(__FILE__) + "/../test_output")

      if Dir.exists?(@output_dir)
        FileUtils.rm_rf(@output_dir)
      end

      Dir.mkdir(@output_dir)

      # Instantiate a new object with the test_input and test_output directories
      @mort = Mortimer::Core.new(@input_dir, @output_dir)
      @mort.process
    end

    context "header and footer processing" do
      methods = %w(header footer)

      methods.each do |method|
        specify "populates #{method}" do
          @mort.send(method).should_not be_nil
        end
      end

      context "fails" do
        # TODO: setup a fake file system

        specify "when header is unavailable"
        specify "when footer is unavailable"
      end
    end

    context "CSS processing" do
      specify "markdown file should be copied to the out directory" do
        File.exists?(@output_dir + "/markdown.css").should be_true
      end
    end

    context "Markdown file processing" do
      context "should process only Markdown files" do

      end
    end
  end
end
