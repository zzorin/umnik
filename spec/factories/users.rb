require 'securerandom'

FactoryBot.define do
  factory :user do
    skip_create
    after(:build) do |user|
      hash = {
        id: SecureRandom.hex,
        name: "Ivan",
        surname: "Ivanov",
        patronymic: "Ivanovich",
        email: "example@mail.com"
      }
      set_user_data user, hash
    end

    factory :administrator do
      after(:build) do |user, _|
        create :permission, user_id: user.id, role: :administrator
      end
    end
  end
end


def set(user, attribute, value, store: false)
  name = "@#{attribute}"
  user.instance_variable_set name, value
  user.define_singleton_method attribute do
    instance_variable_get name
  end
  if store
    hash = RedisUserConnector.get(user.id)
    hash.merge!(attribute => value)
    store_in_redis user.id, hash
  end
end

def set_user_data(user, hash)
  hash.each do |attribute, value|
    set(user, attribute, value)
  end
  store_in_redis user.id, hash
end

def store_in_redis(user_id, hash)
  RedisUserConnector.set user_id, hash.as_json.to_a.flatten
  RedisUserConnector.send(:connection).expire "#{RedisUserConnector.send(:namespace)}:#{user_id}", 1.hour
end
