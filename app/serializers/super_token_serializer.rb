class SuperTokenSerializer < ActiveModel::Serializer
  attributes :user
  def attributes(*args)
      hash = super
      hash[:token] = object.super_tokens.order('id DESC')[0].token unless @instance_options[:hide_token]
      hash
  end
  def user 
      object.attributes.except("password_digest")
  end
end