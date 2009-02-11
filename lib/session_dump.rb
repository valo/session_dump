require File.join(File.dirname(__FILE__), 'version')

module SessionDump
  def self.included(controller)
    # controller.extend(ClassMethods)
    controller.before_filter(:session_dump)
  end

  private
    def session_dump
      logger.debug "  Session: " + session.instance_eval { @data.inspect }
    end
end
