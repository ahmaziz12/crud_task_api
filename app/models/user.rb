class User < ApplicationRecord

  def self.to_csv
    attributes = %w[first_name last_name email address created_at updated_at]
    users = User.all

    CSV.generate(headers: true) do |csv|
      csv << attributes

      users.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
