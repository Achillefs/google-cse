module GoogleCSE
  class Result < Hash
    def initialize(hash = {}, default = nil, &block)
      default ? super(default) : super(&block)
      update(hash)
    end
        
    def method_missing name, *args, &block
      if self.key?(name.to_s)
        self[name.to_s]
      else
        super
      end
    end
  end
end