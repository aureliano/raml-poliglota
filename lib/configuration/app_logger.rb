module RamlPoliglota
  module Configuration

    class AppLogger
    
      @@appenders = []

      def initialize
        if @@appenders.nil?
          AppLogger.add_stdout_logger
        end
      end
    
      def self.add_stdout_logger
        Logging.appenders.stdout(
          :level => :info,
          :layout => Logging::Layouts::Pattern.new(:date_pattern => '%Y-%m-%d %H:%M:%S', :pattern => '[%d] %-5l -- %c : %m\n')
        )
        
        @@appenders << 'stdout' unless @@appenders.include? 'stdout'
      end
      
      def self.create_logger(source)
        if @@appenders.empty?
          puts 'WARNING! There is no appender specified.'
          return nil
        end
        
        logger = Logging.logger[source ||= self]
        logger.add_appenders @@appenders
        
        return logger
      end
    
    end

  end
end