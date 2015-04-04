class Battle
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :time,  type: DateTime
  field :result, type: String
  field :defender_id, type: String
  field :attacker_id, type: String

  belongs_to :mech

  belongs_to :match

  def battle
    # system "../MechBattleConsoleForLinuxServer/MechBattleConsoleForLinuxServer ../MechBattleConsoleForLinuxServer/BattleModeConfig.conf 2 ../MechBattleConsoleForLinuxServer/libmyAI2.so ../MechBattleConsoleForLinuxServer/libmyAI1.so"
  end

  def defender
    Mech.find(self.defender_id)
  end

  def attacker
    Mech.find(self.attacker_id)
  end
end