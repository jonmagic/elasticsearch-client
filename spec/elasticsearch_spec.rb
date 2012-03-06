require 'spec_helper'
require 'elasticsearch'

describe ElasticSearch::JSONResponse do
  describe "#parse" do
    subject { ElasticSearch::JSONResponse.new }

    it "parses json" do
      subject.parse('{"good":"bad"}').should == {"good" => "bad"}
    end
  end
end

describe ElasticSearch::Error do
  subject { ElasticSearch::Error.new }

  it "subclasses StandardError" do
    subject.methods.should include("backtrace")
    subject.methods.should include("exception")
    subject.methods.should include("message")
    subject.methods.should include("set_backtrace")
    subject.methods.should include("to_str")
  end
end

describe ElasticSearch do
  let(:server) { '127.0.0.1' }

  describe ".get_connection" do
    let(:subject) { ElasticSearch.get_connection(server) }

    it "returns immediately without server" do
      Faraday.should_not_receive(:new)
      ElasticSearch.get_connection(nil)
    end

    it "creates faraday instance with server" do
      Faraday.should_receive(:new).with(:url => server)
      subject
    end

    it "returns faraday instance" do
      subject.should be_instance_of(Faraday::Connection)
    end
  end

  describe ".available?" do
    context "connection up" do
      it "returns true" do
        conn = stub(:get => stub(:status => 200))
        ElasticSearch.stub(:get_connection => conn)
        ElasticSearch.available?.should be_true
      end
    end

    context "connection down" do
      it "returns false" do
        conn = stub(:get => stub(:status => 500))
        ElasticSearch.stub(:get_connection => conn)
        ElasticSearch.available?.should be_false
      end
    end
  end
end
