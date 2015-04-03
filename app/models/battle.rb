class Battle
  include Mongoid::Document
  Mongoid.raise_not_found_error = false
  field :time,  type: DateTime
  field :result, type: String
  field :defender_id, type: String
  field :attacker_id, type: String

  belongs_to :mech

  def battle
    # system "../MechBattleConsoleForLinuxServer/MechBattleConsoleForLinuxServer ../MechBattleConsoleForLinuxServer/BattleModeConfig.conf 2 ../MechBattleConsoleForLinuxServer/libmyAI2.so ../MechBattleConsoleForLinuxServer/libmyAI1.so"
  end
end