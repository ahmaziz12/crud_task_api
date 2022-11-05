class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :address

  def full_name
    [object.first_name, object.last_name].compact.join(' ')
  end
end
