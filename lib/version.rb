module SessionDump
  module Version
    Major = '0' 
    Minor = '0' 
    Tiny  = '1' 

    class << self
      def to_s
        [Major, Minor, Tiny].join('.')
      end 
      alias :to_str :to_s
    end 
  end 
end