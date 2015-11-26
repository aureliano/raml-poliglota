require File.expand_path '../../lib/model/class_meta.rb', __FILE__
require File.expand_path '../../lib/model/attribute_meta.rb', __FILE__
require File.expand_path '../../lib/model/method_meta.rb', __FILE__

include RamlPoliglota::Model

def _create_class_meta_interface_model
  ClassMeta.new do |c|
    c.namespace = 'br.mg.gv'
    c.name = 'IModel'
    c.documentation = 'Define a type to API data schema models.'
  end
end

def _create_text_class_interface_model
  text = <<-FIN
package br.mg.gv;

/**
 * Generated by RAML Poliglota.
 *
 * Define a type to API data schema models.
 */
public interface IModel {

}
FIN
  text.rstrip
end

def _create_class_meta_model(name)
  ClassMeta.new do |c|
    c.namespace = 'br.mg.gv'
    c.name = name
    c.documentation = 'A Java Bean class.'
    
    c.add_attribute(AttributeMeta.new do |a|
      a.visibility = 'private'
      a.type = 'Integer'
      a.name = 'id'
    end)
    
    c.add_attribute(AttributeMeta.new do |a|
      a.visibility = 'protected'
      a.type = 'String'
      a.name = 'firstName'
    end)
    
    c.add_attribute(AttributeMeta.new do |a|
      a.visibility = 'protected'
      a.type = 'String'
      a.name = 'lastName'
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'Integer'
      m.name = 'getId'
      m.body = "return this.id;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'void'
      m.name = 'setId'
      m.parameters = [AttributeMeta.new { |a| a.name = 'id'; a.type = 'Integer' }]
      m.body = "this.id = id;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'BilboBaggins'
      m.name = 'withId'
      m.parameters = [AttributeMeta.new { |a| a.name = 'id'; a.type = 'Integer' }]
      m.body = "this.id = id;\nreturn this;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'String'
      m.name = 'getFirstName'
      m.body = "return this.firstName;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'void'
      m.name = 'setFirstName'
      m.parameters = [AttributeMeta.new { |a| a.name = 'firstName'; a.type = 'String' }]
      m.body = "this.firstName = firstName;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'BilboBaggins'
      m.name = 'withFirstName'
      m.parameters = [AttributeMeta.new { |a| a.name = 'firstName'; a.type = 'String' }]
      m.body = "this.firstName = firstName;\nreturn this;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'String'
      m.name = 'getLastName'
      m.body = "return this.lastName;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'void'
      m.name = 'setLastName'
      m.parameters = [AttributeMeta.new { |a| a.name = 'lastName'; a.type = 'String' }]
      m.body = "this.lastName = lastName;"
    end)

    c.add_method(MethodMeta.new do |m|
      m.visibility = 'public'
      m.return_type = 'BilboBaggins'
      m.name = 'withLastName'
      m.parameters = [AttributeMeta.new { |a| a.name = 'lastName'; a.type = 'String' }]
      m.body = "this.lastName = lastName;\nreturn this;"
    end)
  end
end

def _create_text_class_model(name)
  text = <<-FIN
package br.mg.gv;

/**
 * Generated by RAML Poliglota.
 *
 * A Java Bean class.
 */
public class #{name} {

  private Integer id;
  protected String firstName;
  protected String lastName;

  public Integer getId() {
    return this.id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public #{name} withId(Integer id) {
    this.id = id;
    return this;
  }

  public String getFirstName() {
    return this.firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public #{name} withFirstName(String firstName) {
    this.firstName = firstName;
    return this;
  }

  public String getLastName() {
    return this.lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public #{name} withLastName(String lastName) {
    this.lastName = lastName;
    return this;
  }
}
FIN
  text.rstrip
end

CLASS_META_FACTORY = {
  :imodel => {
    :object => _create_class_meta_interface_model,
    :text => _create_text_class_interface_model
  },
  :model => {
    :bilbo_baggins => {
      :object => _create_class_meta_model('BilboBaggins'),
      :text => _create_text_class_model('BilboBaggins')
    },
    :frodo_baggins => {
      :object => _create_class_meta_model('FrodoBaggins'),
      :text => _create_text_class_model('FrodoBaggins')
    }
  }
}