require "google_cse/query"
require "google_cse/result"
require "google_cse/version"

module GoogleCSE
  def self.search query, params = {}
    query(default_params.merge(:q => query).merge(params))
  end
  
  def self.image_search query, params = {}
    query(default_params.merge(:searchType => :image, :q => query).merge(params))
  end
  
  def self.default_params
    { :cx => CX, :key => KEY }
  end

private
  def self.query params
    Query.new(:params => params)
  end
end
