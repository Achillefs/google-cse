require 'spec_helper'

describe GoogleCSE do
  subject { GoogleCSE }
  
  describe 'without config' do
    before {
      GoogleCSE.send(:remove_const, :CX)
      GoogleCSE.send(:remove_const, :KEY)
    }
    
    after {
      GoogleCSE::CX = 'cse-identifier'
      GoogleCSE::KEY = 'custom-search-key'
    }
    
    it { expect {subject.search('lemmy')}.to raise_error(GoogleCSE::MissingCX) }
    it { expect {subject.image_search('lemmy')}.to raise_error(GoogleCSE::MissingCX) }
  end
  
  describe 'with only key' do
    before {
      GoogleCSE.send(:remove_const, :CX)
    }
    
    after {
      GoogleCSE::CX = 'cse-identifier'
    }
    
    it { expect {subject.search('lemmy')}.to raise_error(GoogleCSE::MissingCX) }
    it { expect {subject.image_search('lemmy')}.to raise_error(GoogleCSE::MissingCX) }
  end
  
  describe 'with only cx' do
    before {
      GoogleCSE.send(:remove_const, :KEY)
    }
    
    after {
      GoogleCSE::KEY = 'custom-search-key'
    }
    
    it { expect {subject.search('lemmy')}.to raise_error(GoogleCSE::MissingKey) }
    it { expect {subject.image_search('lemmy')}.to raise_error(GoogleCSE::MissingKey  ) }
  end
  
  describe 'with config' do
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
        subject.fetch
      }
      
      it { subject.results.size.should eq(10) }
      it { subject.results.first.link.should eq(subject.fetch.results.first['link']) }
      it { subject.page.should eq(1) }
      it { subject.current_index.should eq(1) }
      it { subject.per_page.should eq(10) }
      
      describe 'next' do
        before {
          subject.stub(:next) { 
            subject.response = JSON.parse(File.read('./spec/files/google_search_page2.txt'))
            subject.parse_response!
            subject
          }
          subject.fetch
        }
        
        it { subject.next?.should eq(true) }
        it { subject.next.should eq(subject) }
        it { subject.next.current_index.should eq(11) }
        it { subject.next.page.should eq(2) }
      end
      
      describe 'previous' do
        before {
          subject.stub(:next) { 
            subject.response = JSON.parse(File.read('./spec/files/google_search_page2.txt'))
            subject.parse_response!
            subject
          }
          subject.stub(:previous) { 
            subject.response = JSON.parse(File.read('./spec/files/google_search.txt'))
            subject.parse_response!
            subject
          }
          subject.fetch.next
        }
        
        it { subject.previous?.should eq(true) }
        it { subject.previous.should eq(subject) }
        it { subject.previous.current_index.should eq(1) }
        it { subject.previous.page.should eq(1) }
      end
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
end