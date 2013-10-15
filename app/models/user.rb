class User < ActiveRecord::Base

    class << self
        def search(session_id)
            rel = order("id")
            if session_id.present?
                rel = rel.where("session_id LIKE ?", "%#{session_id}%")
            end
            rel
        end
    end

end
