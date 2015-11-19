module RamlPoliglota
  module Configuration

    class AppLogger

      @@default_level = :info

      def self.set_default_level(level)
        if ['debug', 'info', 'warn', 'error'].include? level.to_s.downcase
          @@default_level = level.to_sym
        end
      end
      
      def self.create_logger(source)
        logger = Logging.logger[source ||= self]
        logger.level = @@default_level

        layout = Logging::Layouts::Pattern.new(
          :date_pattern => '%Y-%m-%d %H:%M:%S',
          :pattern => '[%d] %-5l -- %c : %m\n'
        )

        logger.add_appenders(
          Logging.appenders.stdout(
            :level => @@default_level, :layout => layout
          )
        )
        
        return logger
      end
    
    end

  end
end