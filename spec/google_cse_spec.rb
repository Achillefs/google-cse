require 'spec_helper'

describe GoogleCSE do
  subject { GoogleCSE }
  
  it { subject.search('lemmy').should be_a(GoogleCSE::Query) }
  it { subject.image_search('lemmy').should be_a(GoogleCSE::Query) }
  
  describe '#search' do
    subject { GoogleCSE.search('lemmy') }
    before {
      subject.stub(:fetch) { 
        subject.response = JSON.parse(File.read('./spec/files/google_search.txt'))
        subject.parse_response!
        subject
      }
    }
    
    it { subject.fetch.results.size.should eq(10) }
    it { subject.fetch.results.first.link.should eq(subject.fetch.results.first['link']) }
  end
  
  describe '#image_search' do
    subject { GoogleCSE.image_search('lemmy') }
    before {
      subject.stub(:fetch) { 
        subject.response = JSON.parse(File.read('./spec/files/google_image_search.txt'))
        subject.parse_response!
        subject
      }
    }
    
    it { subject.fetch.results.size.should eq(10) }
    it { subject.fetch.results.first.link.should eq(subject.fetch.results.first['link']) }
  end
end