require 'json'
require 'cgi'
require 'open-uri'

module GoogleCSE
  class Query
    @@endpoint = 'https://www.googleapis.com/customsearch/v1'
    attr_accessor :params, :results, :info, :response
  
    def initialize opts = {}
      opts.map {|k,v| send(:"#{k}=",v)}
    end
  
    def search_uri
      "#{@@endpoint}?#{params.map {|k,v|"#{k}=#{CGI.escape(v.to_s)}"}.join('&')}"
    end
  
    def fetch
      @response = JSON.parse(open(search_uri).read)
      parse_response!
      self
    end
  
    def fetch!
      fetch
      nil
    end
  
    def parse_response!
      @results = @response['items'].map { |i| Result.new(i) }
      @next_page_params = @response['queries']['nextpage']
      @prev_page_params = @response['queries']['previouspage']
      @info = @response['searchInformation']
      nil
    end
  end
end