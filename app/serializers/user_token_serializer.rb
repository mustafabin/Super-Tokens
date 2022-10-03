class UserTokenSerializer < ActiveModel::Serializer
  attributes :user, :token
  def token
      object.super_tokens.order('id DESC')[0].token
  end
  def user 
      {id: object.id, email: object.email}
  end
end