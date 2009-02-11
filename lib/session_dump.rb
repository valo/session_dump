module SessionDump
  def self.included(controller)
    # controller.extend(ClassMethods)
    controller.before_filter(:session_dump)
  end

  private
    def session_dump
      logger.debug session.instance_eval { @data.inspect }
    end
end
