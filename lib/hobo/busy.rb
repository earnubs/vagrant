module Hobo
  def self.busy?
    Busy.busy?
  end

  def self.busy(&block)
    Busy.busy(&block)
  end

  class Busy
    @@busy = false
    @@mutex = Mutex.new

    class << self
      def busy?
        @@busy
      end

      def busy=(val)
        @@busy = val
      end

      def busy(&block)
        @@mutex.synchronize do
          begin
            Busy.busy = true
            yield
          ensure
            # In the case an exception is thrown, make sure we restore
            # busy back to some sane state.
            Busy.busy = false
          end
        end
        
        # In the case were an exception is thrown by the wrapped code
        # make sure to set busy to sane state and reraise the error
      ensure
        Busy.busy = false
      end
    end
  end
end
