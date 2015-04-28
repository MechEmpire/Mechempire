class Battle
  require 'open4'
  include Mongoid::Document
  include Mongoid::MagicCounterCache
  Mongoid.raise_not_found_error = false 

  field :time,  type: DateTime
  field :result, type: String
  field :defender_id, type: String
  field :attacker_id, type: String
  field :winner_id, type: String

  has_and_belongs_to_many :meches
  has_and_belongs_to_many :users, class_name: 'User', inverse_of: :battles
  # counter_cache :users

  belongs_to :match

  has_and_belongs_to_many :starers, class_name: 'User', inverse_of: :stareds
  # counter_cache :starers

  def battle

    #run battle in sandbox
    pid, stdin, stdout, stderr = Open4.popen4("battle/battle.sh #{self.defender.code_dir}libmyAI.so #{self.attacker.code_dir}libmyAI.so #{self._id}")
    ignored, status = Process::waitpid2 pid
    logger.error(stderr.read)
    #get battle result

    pid, stdin, stdout, stderr = Open4.popen4("battle/result.sh #{self.defender.code_dir}libmyAI.so #{self.attacker.code_dir}libmyAI.so #{self._id}")
    ignored, status = Process::waitpid2 pid

    logger.error(stderr.read)

    # if status.exitstatus
    #   return false
    # end
    x = File.read("battle/result/#{self._id}.xml")
    # if FileTest::exist?("battle/result/#{self._id}.xml")
    #   x = File.read("battle/result/#{self._id}.xml")
    # else
    #   return false
    # end

    winnerID = Hash.from_xml(x)['battleStatistics']['winnerID']

    sa = 0.0
    sb = 0.0

    if winnerID == "0"
      sb = 1.0
      self.winner_id = self.defender_id
      self.defender.update_attributes(:score => self.defender.score + 3,
                                    :win_times => self.defender.win_times + 1)
      self.defender.user.update_attributes(:win_times => self.defender.user.win_times + 1,
                                      :battle_count => self.defender.user.battle_count + 1)

      self.attacker.update_attributes(:score => self.attacker.score - 1,
                                      :fail_times => self.attacker.fail_times + 1)

      self.attacker.user.update_attributes(:fail_times => self.attacker.user.fail_times + 1,
                                      :battle_count => self.attacker.user.battle_count + 1)
    elsif winnerID == "1"
      sa = 1.0
      self.winner_id = self.attacker_id
      self.attacker.update_attributes(:score => self.attacker.score + 3,
                                      :win_times => self.attacker.win_times + 1)
      self.attacker.user.update_attributes(:win_times => self.attacker.user.win_times + 1,
                                      :battle_count => self.attacker.user.battle_count + 1)

      self.defender.update_attributes(:score => self.defender.score - 1,
                                      :fail_times => self.defender.fail_times + 1,
                                      :protect_begin_time => Time.now.to_i,
                                      :protect_time => 300)
      
      self.defender.user.update_attributes(:fail_times => self.defender.user.fail_times + 1,
                                      :battle_count => self.defender.user.battle_count + 1)
    elsif winnerID == "-1"
      sa = sb = 0.5
      self.winner_id = nil
      self.attacker.update_attribute("draw_times", self.attacker.draw_times + 1)
      self.attacker.user.update_attributes(:draw_times => self.attacker.user.draw_times + 1,
                                           :battle_count => self.attacker.user.battle_count + 1)

      self.defender.update_attribute("draw_times", self.defender.draw_times + 1)
      self.defender.user.update_attributes(:draw_times => self.defender.user.draw_times + 1,
                                           :battle_count => self.defender.user.battle_count + 1)

    end

    ra = self.attacker.user.score
    rb = self.defender.user.score
    ea = 1.0 / (1.0 + 10 **( (rb-ra)/400.0 ) )
    eb = 1.0 / (1.0 + 10 **( (ra-rb)/400.0 ) )
    k = 32 + 16 * (0.9 ** (self.defender.user.battle_count + self.attacker.user.battle_count ))
    ra = ra + k * (sa - ea)
    rb = rb + k * (sb - eb)
    if ra < 0
      ra = 0
    end
    if rb < 0
      rb = 0
    end

    self.attacker.user.update_attribute("score", ra)
    self.defender.user.update_attribute("score", rb)

  end

  def defender
    Mech.find(self.defender_id)
  end

  def attacker
    Mech.find(self.attacker_id)
  end

  def winner
    Mech.find(self.winner_id)
  end
end
