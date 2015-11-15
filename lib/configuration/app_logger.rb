module RamlPoliglota
  module Configuration

    class AppLogger
    
      @@appenders = [
        Logging.appenders.stdout(
          :level => :info,
          :layout => Logging::Layouts::Pattern.new(:date_pattern => '%Y-%m-%d %H:%M:%S', :pattern => '[%d] %-5l -- %c : %m\n')
        )
      ]
      
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