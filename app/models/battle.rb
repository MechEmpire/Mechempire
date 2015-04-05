class Battle
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :time,  type: DateTime
  field :result, type: String
  field :defender_id, type: String
  field :attacker_id, type: String
  field :winner_id, type: String

  belongs_to :mech

  belongs_to :match

  def battle
    system "battle/battle.sh #{self.defender.code_dir}libmyAI.so #{self.attacker.code_dir}libmyAI.so #{self._id}"
    x = File.read("battle/result/#{self._id}.xml")
    winnerID = Hash.from_xml(x)['battleStatistics']['winnerID']
    if winnerID == "0"
      self.winner_id = self.attacker_id
      self.attacker.update_attributes(:score => self.attacker.score + 3,
                                      :win_times => self.attacker.win_times + 1)
      self.defender.update_attributes(:score => self.defender.score - 1,
                                      :fail_times => self.defender.fail_times + 1)
    elsif winnerID == "1"
      self.winner_id = self.defender_id
      self.defender.update_attributes(:score => self.defender.score + 3,
                                      :win_times => self.defender.win_times + 1)
      self.attacker.update_attributes(:score => self.attacker.score - 1,
                                      :fail_times => self.attacker.fail_times + 1)
    elsif winnerID == "-1"
      self.winner_id = nil
      self.attacker.update_attribute("draw_times", self.attacker.draw_times + 1)
      self.defender.update_attribute("draw_times", self.defender.draw_times + 1)
    end
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