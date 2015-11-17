module RamlPoliglota
  module Support
    
    include RamlPoliglota::Model
    
    SUPPORTED_PROGRAMMING_LANGUAGES = {
      :java => ProgrammingLanguage.new do |p|
        p.name = 'Java'
        p.case = 'camel'
      end
    }

  end
end