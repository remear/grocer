require 'spec_helper'
require 'grocer'

describe Grocer do
  subject { described_class }

  describe '.env' do
    let(:environment) { nil }
    before do
      ENV.stubs(:[]).with('RAILS_ENV').returns(environment)
      ENV.stubs(:[]).with('RACK_ENV').returns(environment)
    end

    it 'defaults to development' do
      subject.env.should == 'development'
    end

    it 'reads RAILS_ENV from ENV' do
      ENV.stubs(:[]).with('RAILS_ENV').returns('staging')
      subject.env.should == 'staging'
    end

    it 'reads RACK_ENV from ENV' do
      ENV.stubs(:[]).with('RACK_ENV').returns('staging')
      subject.env.should == 'staging'
    end
  end

  describe '.pusher' do
    let(:connection_options) { stub('connection options') }
    before do
      Grocer::Connection.stubs(:new).returns(stub('Connection'))
    end

    it 'returns a Connection' do
     subject.pusher(connection_options).should be_a Grocer::Pusher
    end

    it 'passes the connection options on to the underlying Connection' do
      subject.pusher(connection_options)
      Grocer::Connection.should have_received(:new).with(connection_options)
    end
  end

end