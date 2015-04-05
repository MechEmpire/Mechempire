class Match
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  
  field :name, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :introduce, type: String
  field :owner, type: String
  has_many :battles
  has_and_belongs_to_many :users
  has_and_belongs_to_many :meches

  def has_end?
    Time.now > self.end_time
  end

  def create_racecard
    meches_count = self.meches.count
    team = self.meches
    user_temp = User.new
    puts team.class
    if meches_count % 2 != 0
      self.meches.push(user_temp)
      meches_count += 1
    end

    for i in 1..meches_count - 1
      team.insert(1, team[-1])
      team.pop

      a = team[0..(meches_count/2 - 1)]
      b = team[meches_count/2..meches_count]
      b = b.reverse

      for j in 0..meches_count/2-1
        if a[j] != user_temp && b[j] != user_temp
          battle = Battle.new(:defender_id => a[j]._id,
                     :attacker_id => b[j]._id,
                     :time => Time.now)
          battle.save
          self.battles << battle
        end
      end
    end
  end
end
