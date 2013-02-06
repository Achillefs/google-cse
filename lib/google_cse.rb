require "google_cse/query"
require "google_cse/result"
require "google_cse/version"

module GoogleCSE
  class MissingKey < StandardError
    def initialize
      super "You need to specify a Google CSE Key (GoogleCSE::KEY = 'my-key-goes-here')"
    end
  end
  
  class MissingCX < StandardError
    def initialize
      super "You need to specify a Google CSE CX (GoogleCSE::CX = 'my-cx-goes-here')"
    end

  end
  
  def self.search query, params = {}
    query({:q => query}.merge(params))
  end
  
  def self.image_search query, params = {}
    query({:searchType => :image, :q => query}.merge(params))
  end

private
  def self.query params
    begin
      Query.new(:params => default_params.merge(params))
    rescue NameError => e
      case e.message
      when 'uninitialized constant GoogleCSE::CX' 
        raise MissingCX
      when 'uninitialized constant GoogleCSE::KEY'
        raise MissingKey
      end
    end
  end
  
  def self.default_params
    { :cx => CX, :key => KEY }
  end
end
